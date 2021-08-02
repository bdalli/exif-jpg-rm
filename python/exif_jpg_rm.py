# Lambda /tmp has 512MB using it to process jpg
# https://aws.amazon.com/blogs/compute/choosing-between-aws-lambda-data-storage-options-in-web-apps/
# Lambda assumes all files are of type jpg because of bucket policy
# Catch all exception handler and log

import json
import boto3
import logging
from exif import Image


destination_bucket = 'jpeg-bucket-b'
source_bucket = 'jpeg-bucket-a'
photo = '/tmp/jpg'
mod_photo = '/tmp/mod_jpg'
s3 = boto3.client('s3')


def upload_modified_photo(key, exif_image=None, photo=None):
    try:
        if photo == None:
            # like before write the file
            with open(mod_photo, 'wb') as mod_image:
                mod_image.write(exif_image.get_file())
            # rb to upload
            with open(mod_photo, 'rb') as mod_image:

                s3.upload_fileobj(
                    mod_image, destination_bucket, key,)
        else:
            s3.put_object(
                Body=photo, Bucket=destination_bucket, Key=key,)    # need to test !!
    except Exception as e:
        logging.error(e)


def handler(event, context):
    source_bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    try:
        # download obj and wr to file
        with open(photo, 'wb') as image:
            s3.download_fileobj(source_bucket, key, image)

        # Read the file and process using the exif lib (rb is a requirement )
        with open(photo, 'rb') as image_file:
            exif_image = Image(image_file)

            if exif_image.has_exif:
                exif_image.delete_all()
                upload_modified_photo(key, exif_image, None)
            else:

                upload_modified_photo(key, None, photo)
    except Exception as e:
        logging.error(e)

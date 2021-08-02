# exif-jpg-rm
POC AWS S3 notifications and a python Lambda.\ 
Assumes user understands how to set terraform aws provider credentials\.
 

Application:\
Python code with https://pypi.org/project/exif/ \
Package located at package/exif-py-packages.zip containing code and dependencies\
Code located python/exif_jpg_rm.py -- see comments \

InfraStructure:
S3 buckets created using  https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest?tab=inputs
Lambda and IAM created using terraform resources 

Improvements:
Lambda:
Tidy up exception handling in the code 
Create a packaging process with tests. 
Move variables to lambda env vars.

Infrastructure:
S3 write a bucket policy restricting type to jpg only -- requires a list of user principles
Add lifecyle, access logging and tags to buckets. For object management, monitoring and grouping/billing 
Set up some Cloudwatch metrics and tags for Lambda. To track execution and grouping/billing 

Simple test: 
aws s3 cp photo/paris_sklyine_1900s.jpg  s3://jpeg-bucket-a/photo/paris_sklyine_1900s.jpg 
aws s3 ls s3://jpeg-bucket-b/photo/ 

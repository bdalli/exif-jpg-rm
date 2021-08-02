# 
# https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest?tab=inputs
# 



module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  for_each = toset(var.bucket_names)
  bucket   = each.value
  acl      = "private"

  versioning = {
    enabled = false
  }

  # Type POC 
  force_destroy = true

  # No public access 
  block_public_acls   = true
  block_public_policy = true

  # Encrypt at REST
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
    # Things to Add :  lifecycle for object management , S3 access logging for monitoring , and tags for grouping and billing  

  }

}


# # ## Could not find a module for this in the registry 
resource "aws_s3_bucket_notification" "s3_jpeg_notifier" {
  bucket = module.s3_bucket["jpeg-bucket-a"].s3_bucket_id

  lambda_function {
    lambda_function_arn = aws_lambda_function.exif_jpg_rm.arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".jpg"
  }
}






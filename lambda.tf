locals {
  package_path = "${path.module}/package/exif-py-packages.zip"
}




resource "aws_lambda_function" "exif_jpg_rm" {
  function_name = "exif-jpg-remove"
  runtime       = "python3.6"
  handler       = "exif_jpg_rm.handler"
  role          = aws_iam_role.lambda_execution.arn
  filename      = local.package_path

}

resource "aws_lambda_permission" "allow_s3_events" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.exif_jpg_rm.arn
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3_bucket["jpeg-bucket-a"].s3_bucket_arn
}

resource "aws_iam_role" "lambda_execution" {
  assume_role_policy  = data.aws_iam_policy_document.lambda_assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
  inline_policy {
    name   = "lambda-exif-remove-jpg-policy"
    policy = data.aws_iam_policy_document.s3_lambda_policy.json
  }
}


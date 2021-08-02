# policy for buckets 

data "aws_iam_policy_document" "s3_lambda_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = ["${module.s3_bucket["jpeg-bucket-a"].s3_bucket_arn}/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject"
    ]
    resources = ["${module.s3_bucket["jpeg-bucket-b"].s3_bucket_arn}/*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["${module.s3_bucket["jpeg-bucket-b"].s3_bucket_arn}/*", "${module.s3_bucket["jpeg-bucket-a"].s3_bucket_arn}/*"]
  }
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}



# lambda_policy for buckets 

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


# user policy document for bucket access  

data "aws_iam_policy_document" "user_a_s3_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [module.s3_bucket["jpeg-bucket-a"].s3_bucket_arn]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]
    resources = ["${module.s3_bucket["jpeg-bucket-a"].s3_bucket_arn}/*"]
  }
}
data "aws_iam_policy_document" "user_b_s3_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [module.s3_bucket["jpeg-bucket-b"].s3_bucket_arn]
  }
  statement {
    effect = "Allow"
    actions = [

      "s3:GetObject"

    ]
    resources = ["${module.s3_bucket["jpeg-bucket-b"].s3_bucket_arn}/*"]
  }
}


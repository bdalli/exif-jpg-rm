output "s3_bucket_a_arn" {
  description = "The name of the bucket."
  value       = module.s3_bucket["jpeg-bucket-a"].s3_bucket_arn
}

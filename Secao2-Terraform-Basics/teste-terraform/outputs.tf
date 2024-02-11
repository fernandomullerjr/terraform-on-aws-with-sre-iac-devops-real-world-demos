
output "s3_bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "s3_bucket_region" {
  value = aws_s3_bucket.my_bucket.region
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn
}

output "s3_bucket_domain_name" {
  value = aws_s3_bucket.my_bucket.bucket_domain_name
}

output "state_bucket_arn" {
  value = aws_s3_bucket.terraform_state_bucket.arn
}

output "lock_table_arn" {
  value = aws_dynamodb_table.terraform_lock_table.arn
}

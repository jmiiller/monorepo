resource "aws_dynamodb_table" "tf_locks" {
  name         = "${var.environment}-tf-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "${var.environment}-tf-state-lock"
    Environment = var.environment
  }
}


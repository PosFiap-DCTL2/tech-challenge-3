resource "aws_dynamodb_table" "analytics-service" {
  name           = "ToggleMasterAnalytics"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "event_id"

  attribute {
    name = "event_id"
    type = "S"
  }
}
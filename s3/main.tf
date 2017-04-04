resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"
  policy = "${var.bucket_policy}"
  acl    = "private"

  tags {
    Name        = "${var.bucket_name}"
    Environment = "${var.environment}"
  }
}

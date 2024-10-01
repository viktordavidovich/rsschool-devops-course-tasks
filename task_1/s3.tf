resource "aws_s3_bucket" "temp_bucket" {
  bucket = "my-temp-bucket-from-terraform"
}

resource "aws_s3_bucket" "temp_buckett" {
  bucket = "my-new-bucket-from-terraform"
}
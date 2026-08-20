provider "aws" {
  region = "us-east-1"
}
resource "aws_s3_bucket" "bucket_inseguro" {
  bucket = "mi-bucket-devsecops-demo-12345"
}
resource "aws_s3_bucket_public_access_block" "publico" {
  bucket = aws_s3_bucket.bucket_inseguro.id
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}
resource "aws_security_group" "sg_inseguro" {
  name = "sg_ssh_abierto"
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

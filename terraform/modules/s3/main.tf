resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_s3_bucket" "origin_bucket" {
  bucket        = "origin-bucket-${random_id.bucket_id.hex}"
  force_destroy = var.force_destroy
  tags = {
    Name        = var.tag_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_ownership_controls" "bucket_owner" {
  bucket = aws_s3_bucket.origin_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "no_public_access" {
  bucket                  = aws_s3_bucket.origin_bucket.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "versioning_enabled" {
  bucket     = aws_s3_bucket.origin_bucket.id
  depends_on = [aws_s3_bucket.origin_bucket]
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket     = aws_s3_bucket.origin_bucket.id
  depends_on = [aws_s3_bucket.origin_bucket]
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm
    }
  }
}

# Uploading website
resource "aws_s3_object" "website_files" {
  for_each     = var.website_files
  bucket       = aws_s3_bucket.origin_bucket.id
  key          = each.value
  source       = "${var.website_path}/${each.value}"
  content_type = "text/html"
}



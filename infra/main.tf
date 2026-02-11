provider "aws" {
  region            = var.region
  access_key        = var.access_key
  secret_key = var.secret_access_key
}

resource "aws_s3_bucket" "public_site" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "public_site" {
  bucket = aws_s3_bucket.public_site.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "public_site" {
  bucket = aws_s3_bucket.public_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

data "aws_iam_policy_document" "public_read" {
  statement {
    sid     = "PublicReadGetObject"
    effect  = "Allow"
    actions = ["s3:GetObject"]
    resources = [
      "${aws_s3_bucket.public_site.arn}/*"
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "public_site" {
  bucket = aws_s3_bucket.public_site.id
  policy = data.aws_iam_policy_document.public_read.json
}

resource "aws_s3_bucket_website_configuration" "public_site" {
  bucket = aws_s3_bucket.public_site.id

  index_document {
    suffix = var.html_object_key
  }
}

resource "aws_s3_object" "html_page" {
  bucket       = aws_s3_bucket.public_site.id
  key          = var.html_object_key
  source       = var.html_file_path
  content_type = "text/html"
  etag         = filemd5(var.html_file_path)

  depends_on = [
    aws_s3_bucket_ownership_controls.public_site,
    aws_s3_bucket_public_access_block.public_site,
    aws_s3_bucket_policy.public_site
  ]
}

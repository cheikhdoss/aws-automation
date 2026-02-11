output "bucket_name" {
	value = aws_s3_bucket.public_site.id
}

output "website_endpoint" {
	value = aws_s3_bucket.public_site.website_endpoint
}
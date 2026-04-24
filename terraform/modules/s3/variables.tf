variable "force_destroy" {
  description = "Boolean that indicates all objects should be deleted from the bucket when the bucket is destroyed so that bucket can be destroyed without any error"
  type        = bool
  default     = false
}

variable "tag_name" {
  description = "Tag for s3 bucket"
  type        = string
  default     = "Origin Bucket"
}

variable "environment" {
  description = "Working environment"
  type        = string
  default     = "Development"
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm to use"
  type        = string
  default     = "AES256"

  validation {
    condition     = contains(["AES256", "aws:kms", "aws:kms:dsse"], var.sse_algorithm)
    error_message = "sse_algorithm must be either 'AES256','aws:kms' or 'aws:kms:dsse'."
  }
}

variable "website_path" {
  description = "Path to website files"
  type        = string
  default     = "../website"
}

variable "website_files" {
  type = map(string)
  default = {
    index = "index.html"
    error = "error.html"
  }
}
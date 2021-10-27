require "aws-sdk"

if ["staging", "production"].include? Rails.env
  S3_CLIENT = Aws::S3::Client.new(
    region: 'ap-southeast-1'
  )

  S3_RESOURCE = Aws::S3::Resource.new client: S3_CLIENT
  S3_PRESIGNER = Aws::S3::Presigner.new client: S3_CLIENT
  S3_BUCKET = S3_RESOURCE.bucket 'testawsbucket-minh'
end
CarrierWave.configure do |config|
  config.storage = :aws
  config.aws_bucket = 'testawsbucket-minh'
  config.aws_acl = 'private'

  config.aws_authenticated_url_expiration = 60

  config.aws_attributes = {
    expires: 1.week.from_now.httpdate,
    cache_control: 'max-age=604800'
  }

  config.aws_credentials = {
    region: 'ap-southeast-1',
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  }
end

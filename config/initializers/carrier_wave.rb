S3Buckets = {
  "production" => "raidit",
  "development" => "raidit-dev",
  "test" => "raidit-test"
}

CarrierWave.configure do |config|
  config.s3_access_key_id = ENV["AWS_KEY"]
  config.s3_secret_access_key = ENV["AWS_SECRET"]
  config.s3_bucket = S3Buckets[Rails.env]
end

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


module CarrierWave
  class SanitizedFile
    private

    # Sanitize the filename, to prevent hacking
    def sanitize(name)
      name = name.gsub("\\", "/") # work-around for IE
      name = File.basename(name)
      name = name.gsub(/[^a-zA-Z0-9\.\-\+_]/,"_")
      name = "_#{name}" if name =~ /\A\.+\z/
      name = "unnamed" if name.size == 0
      name
    end
  end
end

if Rails.env.production? && ENV['MONGOHQ_URL']
  uri = URI.parse(ENV['MONGOHQ_URL'])
  MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'], :logger => Rails.logger)
  MongoMapper.database = uri.path.gsub(/^\//, '')
end

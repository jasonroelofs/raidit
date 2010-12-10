ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require Rails.root.join(*%w(test_helpers factory))

DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  include Devise::TestHelpers 

  setup do
    DatabaseCleaner.clean
  end

  def sign_in_as(name)
  end

end

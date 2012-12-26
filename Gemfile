source :rubygems

gem "rails", "~> 3.2.0"

gem "bcrypt-ruby", :require => "bcrypt"

gem "simple_form"
gem "state_machine", "~> 1.1.0"

# Assets
gem "select2-rails"
gem "jquery-rails"
gem "jquery-qtip2-rails"

gem "pg"

group :assets do
  gem "sass-rails", "~> 3.2.0"
  gem "coffee-rails", "~> 3.2.0"
  gem "uglifier", ">= 1.0.3"
  gem "bootstrap-sass", "~> 2.0.3"
end

group :development do
  gem "pry", :require => false
  gem "rake"
  gem "thin"
  gem "debugger", :platform => :mri
end

group :test do
  gem "minitest"
  gem "minitest-spec-rails"
  gem "mocha"
end

group :cucumber do
  gem "cucumber-rails", :require => false
  gem "timecop"
  gem "poltergeist", :git => "git://github.com/jonleighton/poltergeist.git", :require => false
end

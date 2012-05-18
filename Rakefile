require File.expand_path("../config/application", __FILE__)
require 'rake/testtask'

Raidit::Application.load_tasks

task :default => "test:all"

namespace :test do
  desc "Run all tests"
  task :all => [:units, :integrations]

  desc "Run all unit tests"
  Rake::TestTask.new :units do |t|
    t.pattern = "test/unit/**/*_test.rb"
    t.libs = ["lib", "app", "test"]
  end

  desc "Run all integration tests"
  Rake::TestTask.new :integrations do |t|
    t.pattern = "test/integration/**/*_test.rb"
    t.libs = ["lib", "app", "test"]
  end
end
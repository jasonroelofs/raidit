require File.expand_path("../config/application", __FILE__)
require 'rake/testtask'

Raidit::Application.load_tasks

task :default => "test:all"

namespace :test do
  desc "Run all tests"
  task :all => [:units]

  desc "Run all unit tests"
  Rake::TestTask.new :units do |t|
    t.pattern = "test/unit/**/*_test.rb"
    t.libs = ["lib", "app", "test/unit"]
  end
end
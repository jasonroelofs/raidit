require File.expand_path("../config/application", __FILE__)
require 'rake/testtask'
require 'cucumber/rake/task'

Raidit::Application.load_tasks

task :default => "test:all"

namespace :test do
  desc "Run all tests"
  task :all => [:units, :controllers, :features, :features_slow, :repositories]

  desc "Run all unit tests"
  Rake::TestTask.new :units do |t|
    t.pattern = "test/unit/**/*_test.rb"
    t.libs = ["lib", "app", "test"]
  end

  desc "Run all controller tests"
  Rake::TestTask.new :controllers do |t|
    t.pattern = "test/controllers/**/*_test.rb"
    t.libs = ["lib", "app", "test"]
  end

  desc "Run all repository tests"
  Rake::TestTask.new :repositories do |t|
    t.pattern = "test/repositories/**/*_test.rb"
    t.libs = ["lib", "app", "test"]
  end

  desc "Run the fast cucumber features"
  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features --tags ~@javascript --format progress"
  end

  desc "Run the slow cucumber features"
  Cucumber::Rake::Task.new(:features_slow) do |t|
    t.cucumber_opts = "features --tags @javascript --format progress"
  end
end

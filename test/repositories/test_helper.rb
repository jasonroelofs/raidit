ENV["RAILS_ENV"] = "test"
ENV["REAL_DB"] = "true"
require File.expand_path('../../../config/environment', __FILE__)
require 'rails/test_help'

require 'rails_test_patches'
require 'database_cleaner'

require 'bcrypt'
Kernel.silence_warnings { BCrypt::Engine::DEFAULT_COST = 1 }

DatabaseCleaner.strategy = :transaction

class MiniTest::Unit::TestCase

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def check_model_attributes(model, raw_attributes)
    raw_attributes.each do |attr, expected_value|
      actual_value = model.send(attr)
      actual_value.must_equal(expected_value)
    end
  end

  def self.it_must_be_a_repo_wrapping(ar_class, domain_class, raw_attributes = {})
    describe "#find" do
      it "finds the #{domain_class} by id and converts to domain model" do
        ar_model = ar_class.create(raw_attributes)

        domain_model = @repo.find(ar_model.id)
        domain_model.wont_be_nil

        domain_model.must_be_kind_of domain_class
        domain_model.id.must_equal ar_model.id

        check_model_attributes(domain_model, raw_attributes)
      end
    end

    describe "#save" do
      it "takes the #{domain_class}, stores it in the db" do
        domain_model = domain_class.new(raw_attributes)

        @repo.save(domain_model)

        ar_model = ar_class.all.first
        ar_model.wont_be_nil

        check_model_attributes(ar_model, raw_attributes)

        domain_model.id.must_equal ar_model.id
      end

      it "updates an existing #{domain_class} in the db with the same id" do
        domain_model = domain_class.new(raw_attributes)

        @repo.save(domain_model)

        domain_model.send("#{raw_attributes.keys.first}=", "poostank")

        @repo.save(domain_model)

        ar_class.count.must_equal 1

        ar_model = ar_class.find(domain_model.id)
        ar_model[raw_attributes.keys.first].must_equal "poostank"
      end
    end
  end

end

if ENV["NO_COLOR_OUTPUT"].nil?
  require 'minitest/pride'
  MiniTest::Unit.output = PrideLOL.new(MiniTest::Unit.output)
end

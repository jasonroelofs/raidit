require 'unit/test_helper'
require 'entity'

describe Entity do
  include ActiveModel::Lint::Tests

  class TestEntity
    include Entity

    attr_accessor :field1, :field2
  end

  before do
    @model = TestEntity.new
  end

  it "includes all of ActiveModel" do
    TestEntity.ancestors.must_include ActiveModel::Validations
    TestEntity.ancestors.must_include ActiveModel::Conversion
  end

  it "sets up a constructor to take any defined values" do
    e = TestEntity.new :field1 => "value", :field2 => "key"
    e.field1.must_equal "value"
    e.field2.must_equal "key"
  end

  it "errors if a hash value doesn't match a known attribute" do
    lambda {
      e = TestEntity.new :johnson => "what?"
    }.must_raise NoMethodError
  end

  it "gives including class an #id field" do
    e = TestEntity.new :id => 14
    e.id.must_equal 14
  end

  it "is knows if it is persisted" do
    TestEntity.new.persisted?.must_equal false
    TestEntity.new(:id => 14).persisted?.must_equal true
  end

  it "compares equality like ActiveRecord does, by id and instance type" do
    obj1 = TestEntity.new :id => 1, :field1 => "Fielder", :field2 => "Johnson"
    obj2 = obj1.clone

    obj2.must_equal obj1

    obj2.field1 = "Something Else"
    obj2.must_equal obj1

    obj2.id = 10
    obj2.wont_equal obj1
  end
end

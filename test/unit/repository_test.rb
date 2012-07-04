require 'unit/test_helper'

describe Repository do
  class Johnson
  end

  class TestClass
  end

  class TestClassRepository
  end

  it "allows configuring classes to repository implementations" do
    Repository.configure TestClass => TestClassRepository
    Repository.for(TestClass).must_equal TestClassRepository
  end

  it "allows strings for configuration instead of classes" do
    Repository.configure "TestClass" => TestClassRepository
    Repository.for(TestClass).must_equal TestClassRepository
  end

  it "returns nil if no known repository" do
    Repository.for(Johnson).must_be_nil
  end

  it "allows reseting all known repository mappings" do
    Repository.configure "TestClass" => TestClassRepository

    Repository.reset!

    Repository.for(TestClass).must_be_nil
  end
end

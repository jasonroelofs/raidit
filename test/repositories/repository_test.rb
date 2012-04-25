require 'test_helper'
require 'repositories/repository'

describe Repository do
  it "exists" do
    Repository.new.wont_be_nil
  end

  it "can be given a data store" do
    data_store = {}
    Repository.store = data_store

    Repository.store.must_equal data_store
  end
end
require 'test_helper'
require 'models/realm'

describe Realm do
  before do
    @realm = Realm.new "US", "Detheroc", "US-Eastern"
  end

  it "exists" do
    @realm.wont_be_nil
  end

  it "has a name" do
    @realm.name.must_equal "Detheroc"
  end

  it "has a timezone" do
    @realm.timezone.must_equal "US-Eastern"
  end

  it "has a region" do
    @realm.region.must_equal "US"
  end
end
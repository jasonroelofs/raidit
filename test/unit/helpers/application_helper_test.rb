require 'unit/test_helper'

require 'helpers/application_helper'

describe ApplicationHelper do
  include ApplicationHelper

  describe "#normalize_name" do
    it "lowercases everything" do
      normalize_name("SomETHing").must_equal "something"
    end

    it "removes spaces" do
      normalize_name("This is cool").must_equal "thisiscool"
    end

    it "turns nil into the empty string" do
      normalize_name(nil).must_equal ""
    end
  end

end

require 'unit/test_helper'
require 'models/signup'
require 'interactors/find_signup'

describe FindSignup do

  describe ".by_id" do
    it "returns the signup with the given id" do
      s = Signup.new id: 4
      Repository.for(Signup).save(s)

      FindSignup.by_id(4).must_equal s
    end
  end

end

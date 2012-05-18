require 'unit/test_helper'
require 'interactors/register_user'

describe  RegisterUser do
  it "exists" do
    RegisterUser.new.wont_be_nil
  end

  describe "#run" do
    before do
      @email = "email@me.com"
      @password = "password"
      @pw_confirmation = "password"

      @action = RegisterUser.new
    end

    it "errors if email doesn't match an email address"

    it "errors if password doesn't match password confirmation" do
      @action.password = "johnson"

      -> {
        @action.run @email, @password, "not matching"
      }.must_raise RuntimeError
    end

    it "saves a valid user to the data store" do
      @action.run @email, @password, @pw_confirmation

      user = Repository.for(User).all.first
      user.email.must_equal @email
    end

    it "encrypts the password before saving the user"
  end
end

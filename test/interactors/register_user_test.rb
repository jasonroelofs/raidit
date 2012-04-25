require 'test_helper'
require 'interactors/register_user'

describe  RegisterUser do
  it "exists" do
    RegisterUser.new.wont_be_nil
  end

  it "takes an email" do
    action = RegisterUser.new
    action.email = "email@me.com"
    action.email.must_equal "email@me.com"
  end

  it "takes a password" do
    action = RegisterUser.new
    action.password = "test"
    action.password.must_equal "test"
  end

  it "takes a password confirmation" do
    action = RegisterUser.new
    action.password_confirmation = "test"
    action.password_confirmation.must_equal "test"
  end

  describe "#run" do
    before do
      @email = "email@me.com"
      @password = "password"
      @pw_confirmation = "password"

      @action = RegisterUser.new
      @action.email = @email
      @action.password = @password
      @action.password_confirmation = @pw_confirmation
    end

    it "errors if no email" do
      @action.email = nil

      -> {
        @action.run
      }.must_raise RuntimeError
    end

    it "errors if no password" do
      @action.password = nil

      -> {
        @action.run
      }.must_raise RuntimeError
    end

    it "errors if email doesn't match an email address"

    it "errors if password doesn't match password confirmation" do
      @action.password = "johnson"

      -> {
        @action.run
      }.must_raise RuntimeError
    end

    it "saves a valid user to the data store" do
      @action.run

      user = UserRepository.all.first
      user.email.must_equal @email
    end

    it "encrypts the password before saving the user"
  end
end
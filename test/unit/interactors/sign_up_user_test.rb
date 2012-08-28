require 'unit/test_helper'
require 'interactors/sign_up_user'

describe SignUpUser do

  before do
    @params = {
      :login => "login",
      :password => "passy",
      :password_confirmation => "passy",
      :email => "johnson@gass.com"
    }
  end

  it "takes user information and creates a new User" do
    action = SignUpUser.new
    action.run(@params).must_equal true

    user = Repository.for(User).all.first
    user.wont_be_nil

    user.login.must_equal "login"
    user.email.must_equal "johnson@gass.com"

    assert user.password == "passy"
  end

  it "errors out if user is invalid" do
    action = SignUpUser.new
    action.run(@params.merge(:login => "")).must_equal false

    assert Repository.for(User).all.empty?
  end

  it "errors out if passwords don't match" do
    action = SignUpUser.new
    action.run(@params.merge(:password => "johnson")).must_equal false

    assert Repository.for(User).all.empty?
  end

  it "errors out if passwords are blank" do
    action = SignUpUser.new
    action.run(@params.merge(:password => "", :password_confirmation => "")).must_equal false

    assert Repository.for(User).all.empty?
  end

  it "allows access to the created user" do
    action = SignUpUser.new
    action.run(@params)
    action.user.must_equal Repository.for(User).all.first
  end

end

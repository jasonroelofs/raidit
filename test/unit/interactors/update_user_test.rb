require 'unit/test_helper'
require 'interactors/update_user'

describe UpdateUser do
  before do
    @user = User.new :login => "mylogin", :email => "testemail@example.com",
      :password => "password"
    Repository.for(User).save(@user)
  end

  it "can update the user's login" do
    action = UpdateUser.new @user
    action.run :login => "newLogin"

    user = Repository.for(User).find_by_login("newLogin")
    user.must_equal @user
  end

  it "can update the user's email" do
    action = UpdateUser.new @user
    action.run :email => "new@email.com"

    user = Repository.for(User).find_by_login("mylogin")
    user.wont_be_nil
    user.email.must_equal "new@email.com"
  end

  it 'can trigger a change password' do
    action = UpdateUser.new @user
    action.run(
      :current_password => "password",
      :new_password => "winning",
      :confirm_new_password => "winning")

    user = Repository.for(User).find_by_login("mylogin")
    user.password.must_be :==, "winning"
  end

    # Error cases:
    # email already taken
    # user login already taken
    # email empty
    # login empty
end

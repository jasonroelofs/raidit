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

  describe "changing the password" do
    before do
      @action = UpdateUser.new @user
    end

    it "errors if the current password isn't right" do
      @action.run(
        :current_password => "johnson",
        :new_password => "winning",
        :confirm_new_password => "winning"
      ).must_equal false

      user = @action.user
      user.password.must_equal "password"

      user.errors.get(:current_password).must_equal ["Current password is incorrect"]
    end

    it "errors if the new and confirm don't match" do
      @action.run(
        :current_password => "password",
        :new_password => "winning",
        :confirm_new_password => "losing"
      ).must_equal false

      user = Repository.for(User).find_by_login("mylogin")
      user.password.must_equal "password"

      user = @action.user
      user.password.must_equal "password"

      user.errors.get(:new_password).must_equal ["New passwords don't match"]
    end

    it "allows changing password if all fields are valid" do
      @action.run(
        :current_password => "password",
        :new_password => "winning",
        :confirm_new_password => "winning"
      ).must_equal true

      user = Repository.for(User).find_by_login("mylogin")
      user.password.must_equal "winning"
    end

  end


    # Error cases:
    # email already taken
    # user login already taken
    # email empty
    # login empty
end

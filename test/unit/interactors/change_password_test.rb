require 'unit/test_helper'
require 'models/user'
require 'interactors/change_password'

describe ChangePassword do

  before do
    @user = User.new :login => "mylogin", :email => "testemail@example.com",
      :password => "password"

    @action = ChangePassword.new @user
  end

  it "errors if the current password isn't right" do
    user = @action.run("johnson", "winning", "winning")

    user.password.must_equal "password"
    user.errors.get(:current_password).must_equal ["Current password is incorrect"]
  end

  it "errors if the new and confirm don't match" do
    user = @action.run("password", "winning", "losing")

    user.password.must_equal "password"
    user.errors.get(:new_password).must_equal ["New passwords don't match"]
  end

  it "allows changing password if all fields are valid" do
    user = @action.run("password", "winning", "winning")

    user.password.must_equal "winning"
    user.errors.must_be_empty
  end

end

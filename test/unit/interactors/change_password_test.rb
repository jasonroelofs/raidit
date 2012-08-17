require 'unit/test_helper'
require 'interactors/change_password'

describe ChangePassword do

  before do
    @user = User.new :login => "mylogin", :email => "testemail@example.com",
      :password => "password"
    Repository.for(User).save(@user)

    @action = ChangePassword.new @user
  end

  it "errors if the current password isn't right" do
    @action.run("johnson", "winning", "winning").must_equal false

    user = @action.user
    user.password.must_equal "password"

    user.errors.get(:current_password).must_equal ["Current password is incorrect"]
  end

  it "errors if the new and confirm don't match" do
    @action.run("password", "winning", "losing").must_equal false

    user = Repository.for(User).find_by_login("mylogin")
    user.password.must_equal "password"

    user = @action.user
    user.password.must_equal "password"

    user.errors.get(:new_password).must_equal ["New passwords don't match"]
  end

  it "allows changing password if all fields are valid" do
    @action.run("password", "winning", "winning").must_equal true

    user = Repository.for(User).find_by_login("mylogin")
    user.password.must_equal "winning"
  end

end

require 'unit/test_helper'
require 'models/user'
require 'interactors/find_user'

describe FindUser do

  it "exists" do
    FindUser.new.wont_be_nil
  end

  it "can find a user by web session token" do
    user = User.new
    user.web_session_token = "token"
    Repository.for(User).save user

    action = FindUser.new
    found = action.by_web_session_token "token"

    found.must_equal user
  end

end
require 'controllers/test_helper'

class CommentsControllerTest < ActionController::TestCase
  tests CommentsController

  describe "#create" do
    it "requires a logged in user" do
      post :create, {}
      must_redirect_to login_path
    end

    it "adds the posted info as a comment to the current signup" do
      login_as_user

      raid = Raid.new id: 4
      signup = Signup.new id: 6, raid: raid

      FindSignup.expects(:by_id).with(4).returns(signup)
      CommentOnSignup.any_instance.expects(:run).with("This is unacceptable!")

      post :create, :signup_id => 4, :comment => {
        :comment => "This is unacceptable!"
      }

      must_redirect_to raid_path(raid)
    end

    it "doesn't add a comment if can't find the signup" do
      login_as_user

      FindSignup.expects(:by_id).with(4).returns(nil)
      CommentOnSignup.any_instance.expects(:run).never

      post :create, :signup_id => 4, :comment => {
        :comment => "This is unacceptable!"
      }

      must_redirect_to root_path
    end

    it "renders the new comment to json on successful XHR request" do
      login_as_user

      raid = Raid.new id: 4
      signup = Signup.new id: 6, raid: raid

      FindSignup.expects(:by_id).with(4).returns(signup)
      CommentOnSignup.any_instance.expects(:run).with("This is unacceptable!")

      post :create, :signup_id => 4, :comment => {
        :comment => "This is unacceptable!"
      }

      must_redirect_to raid_path(raid)
    end
  end
end

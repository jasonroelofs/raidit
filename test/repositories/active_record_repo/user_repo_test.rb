require 'repositories/test_helper'

describe ActiveRecordRepo::UserRepo do

  before do
    @repo = ActiveRecordRepo::UserRepo.new
  end

  it_must_be_a_repo_wrapping ActiveRecordRepo::Models::User, ::User,
    {:login => "Login", :email => "email@example.com", :password_hash => "hashie"}

  describe "#save" do
    it "sets login tokens on the user" do
      user = ::User.new(:login => "myxo", :email => "cold@play.com")
      user.password = "pass the salt"
      user.set_login_token(:web, "parkour")

      @repo.save(user)

      ar_user = ActiveRecordRepo::Models::User.all.first
      ar_user.login_tokens.must_equal "web" => "parkour"
    end
  end

  describe "#find_by_login" do
    before do
      ActiveRecordRepo::Models::User.create(:login => "testing1")
      ActiveRecordRepo::Models::User.create(:login => "picakboo")
      ActiveRecordRepo::Models::User.create(:login => "proper")
    end

    it "finds the User by given login" do
      found = @repo.find_by_login("testing1")
      found.wont_be_nil
      found.login.must_equal "testing1"
    end

    it "returns nil if no user with that login found" do
      @repo.find_by_login("thefu?").must_be_nil
    end
  end

  describe "#find_by_login_token" do
    before do
      ActiveRecordRepo::Models::User.create(:login_tokens => {:web => "12345", :mobile => "09876"})
      ActiveRecordRepo::Models::User.create(:login_tokens => {:web => "88766"})
      ActiveRecordRepo::Models::User.create()
    end

    it "finds the User by given login token" do
      user = @repo.find_by_login_token(:web, "12345")
      user.wont_be_nil
      user.login_token(:web).must_equal "12345"
      user.login_token(:mobile).must_equal "09876"
    end

    it "returns nil if no user found w/ login token type and value" do
      @repo.find_by_login_token(:mobile, "12345").must_be_nil
      @repo.find_by_login_token(:iphone, "09988").must_be_nil
    end
  end

  it "converts login tokens to indifferent access on load" do
    ActiveRecordRepo::Models::User.create :login_tokens => {:web => "token"}

    user = ActiveRecordRepo::Models::User.all.first
    user.login_tokens[:web].must_equal "token"
  end

end

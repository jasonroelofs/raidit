require 'repositories/test_helper'

describe ActiveRecordRepo::UserRepo do

  before do
    @repo = ActiveRecordRepo::UserRepo.new
  end

  describe "#find" do
    it "finds the user by id and convers to domain model" do
      ar_user = ActiveRecordRepo::Models::User.create(
        :login => "Johnson", :email => "my@example.com", :password_hash => "hashor")

      user = @repo.find(ar_user.id)
      user.wont_be_nil

      user.must_be_kind_of ::User
      user.id.must_equal ar_user.id
      user.login.must_equal "Johnson"
      user.email.must_equal "my@example.com"
      user.password_hash.must_equal "hashor"
    end
  end

  describe "#save" do
    it "takes the User, stores it in the db" do
      user = ::User.new(:login => "myxo", :email => "cold@play.com")
      user.password = "pass the salt"

      @repo.save(user)

      ar_user = ActiveRecordRepo::Models::User.all.first
      ar_user.wont_be_nil
      ar_user.login.must_equal "myxo"
      ar_user.email.must_equal "cold@play.com"
      ar_user.password_hash.wont_be_nil

      user.id.must_equal ar_user.id
    end

    it "updates an existing User in the db with the same id" do
      user = ::User.new(:login => "myxo", :email => "cold@play.com")
      user.password = "pass the salt"

      @repo.save(user)

      user.email = "wrong@email.org"
      user.login = "partyboy"

      @repo.save(user)

      ActiveRecordRepo::Models::User.count.must_equal 1

      ar_user = ActiveRecordRepo::Models::User.find(user.id)
      ar_user.email.must_equal "wrong@email.org"
      ar_user.login.must_equal "partyboy"
      ar_user.password_hash.to_s.must_equal user.password_hash.to_s
    end

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
      user.login_token("web").must_equal "12345"
      user.login_token("mobile").must_equal "09876"
    end

    it "returns nil if no user found w/ login token type and value" do
      @repo.find_by_login_token(:mobile, "12345").must_be_nil
      @repo.find_by_login_token(:iphone, "09988").must_be_nil
    end
  end

end

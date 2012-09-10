require 'unit/test_helper'
require 'interactors/find_character'
require 'models/user'

describe FindCharacter do
  before do
    Repository.for(User).save User.new
    @user = Repository.for(User).all.first
  end

  it "can find a raid by id" do
    Repository.for(Character).save Character.new(name: "Weemoo", id: 1, user: @user)

    c = FindCharacter.new(@user).by_id 1

    c.wont_be_nil
    c.name.must_equal "Weemoo"
  end

  it "only finds characters owned by the given current user" do
    Repository.for(User).save User.new
    user2 = Repository.for(User).all[1]

    Repository.for(Character).save Character.new(name: "Weemoo", id: 2, user: user2)

    FindCharacter.new(@user).by_id(2).must_be_nil
  end

end

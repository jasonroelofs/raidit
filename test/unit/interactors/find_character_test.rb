require 'unit/test_helper'
require 'interactors/find_character'

describe FindCharacter do

  it "can find a raid by id" do
    Repository.for(Character).save Character.new(name: "Weemoo", id: 1)

    c = FindCharacter.by_id 1

    c.wont_be_nil
    c.name.must_equal "Weemoo"
  end

end

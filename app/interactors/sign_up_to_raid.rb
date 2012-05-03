require 'repository'
require 'models/signup'

class SignUpToRaid

  attr_accessor :user, :raid, :character, :group

  def run
    raise "Requires a raid" unless @raid
    raise "Requires a character" unless @character
    raise "Requires a user" unless @user
    if @group && !@raid.groups.include?(@group)
      raise "This raid doesn't have the #{@group} group"
    end

    signup = Signup.new raid: @raid, character: @character, group: @group
    Repository.for(Signup).save signup
  end

end
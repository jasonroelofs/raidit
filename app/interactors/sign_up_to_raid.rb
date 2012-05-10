require 'repository'
require 'models/signup'

class SignUpToRaid

  attr_accessor :current_user, :current_raid

  def initialize(current_user, current_raid)
    @current_user = current_user
    @current_raid = current_raid
  end

  def run(character, group = nil)
    if group && !@current_raid.groups.include?(group)
      raise "This raid doesn't have the #{@group} group"
    end

    signup = Signup.new raid: @current_raid, character: character, group: group
    Repository.for(Signup).save signup
  end

end
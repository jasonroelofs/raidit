require 'repository'
require 'models/signup'

class SignUpToRaid

  attr_accessor :current_user, :current_raid

  def initialize(current_user, current_raid)
    @current_user = current_user
    @current_raid = current_raid
  end

  def run(character, role = nil)
    if role && !@current_raid.roles.include?(role)
      raise "This raid doesn't have the #{@role} role"
    end

    signup = Signup.new raid: @current_raid, user: @current_user,
      character: character, role: role

    Repository.for(Signup).save signup
  end

end

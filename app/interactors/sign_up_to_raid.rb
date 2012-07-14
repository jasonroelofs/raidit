require 'repository'
require 'models/signup'
require 'models/raid'
require 'models/character'

class SignUpToRaid

  attr_accessor :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def run(raid, character, role = nil)
    if role && !raid.roles.include?(role)
      raise "This raid doesn't have the #{role} role"
    end

    signup = Signup.new raid: raid, user: @current_user,
      character: character, role: role

    Repository.for(Signup).save signup
  end

end

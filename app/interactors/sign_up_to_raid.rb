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
    if role && !raid.has_role?(role)
      raise "Unknown role: #{role}"
    end

    signup = Signup.new raid: raid, user: @current_user,
      character: character, role: role

    Repository.for(Signup).save signup
  end

end

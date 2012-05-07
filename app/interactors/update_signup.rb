require 'repository'
require 'models/signup'

class UpdateSignup

  attr_accessor :current_user, :raid, :signup, :new_state

  def run
    raise "Requires a raid" unless @raid
    raise "Requires a signup" unless @signup
    raise "Requires a user" unless @current_user

    @signup.state = @new_state
    Repository.for(Signup).save @signup
  end

end
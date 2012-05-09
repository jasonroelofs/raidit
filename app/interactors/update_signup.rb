require 'repository'
require 'models/signup'
require 'state_machine'
require 'interactors/check_user_permissions'

class UpdateSignup

  attr_accessor :current_user, :raid, :signup, :action

  def run
    raise "Requires a raid" unless @raid
    raise "Requires a signup" unless @signup
    raise "Requires a user" unless @current_user
    raise "Requires an action" unless @action

    permissions = CheckUserPermissions.new(
      :current_user => @current_user
    )

    processor = StateProcessor.new @signup.state, permissions
    processor.send @action
    @signup.state = processor.new_state

    Repository.for(Signup).save @signup
  end

  class StateProcessor
    def initialize(initial_state, permissions)
      super()

      self.signup_state = initial_state
      @permissions = permissions
    end

    def new_state
      self.signup_state.to_sym
    end

    state_machine :signup_state do
      state :accepted
      state :available
      state :cancelled

      event :accept do
        transition :available => :accepted, :if => :can_accept_signup?
      end

      event :unaccept do
        transition :accepted => :available, :if => :can_unaccept_signup?
      end

      event :enqueue do
        transition :cancelled => :available, :if => :can_enqueue_signup?
      end

      event :cancel do
        transition :accepted => :cancelled, :if => :can_cancel_signup?
        transition :available => :cancelled, :if => :can_cancel_signup?
      end
    end

    def can_accept_signup?
      @permissions.allowed? :accept_signup
    end

    def can_unaccept_signup?
      @permissions.allowed? :unaccept_signup
    end

    def can_enqueue_signup?
      @permissions.allowed? :enqueue_signup
    end

    def can_cancel_signup?
      @permissions.allowed? :cancel_signup
    end
  end

end
require 'repository'
require 'models/signup'
require 'state_machine'
require 'interactors/check_user_permissions'

class UpdateSignup

  attr_accessor :current_user, :signup

  def initialize(current_user, signup)
    @current_user = current_user
    @signup = signup
  end

  ##
  # +action+ can be one of :accept, :unaccept, :enqueue, or :cancel
  ##
  def run(action)
    permissions = CheckUserPermissions.new @current_user

    processor = StateProcessor.new @current_user, @signup, permissions
    processor.send action
    @signup.acceptance_status = processor.new_status

    Repository.for(Signup).save @signup
  end

  class StateProcessor
    def initialize(current_user, signup, permissions)
      super()

      @signup = signup
      @current_user = current_user
      self.signup_status = @signup.acceptance_status
      @permissions = permissions
    end

    def new_status
      self.signup_status.to_sym
    end

    state_machine :signup_status do
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
      @current_user == @signup.user
    end

    def can_cancel_signup?
      @current_user == @signup.user
    end
  end

end

##
# Access control macros for controllers
##
module AccessControl
  extend ActiveSupport::Concern

  module ClassMethods

    # Require a logged in user
    def requires_user(options = {})
      before_filter :require_user, options
    end

  end

  included do
    protected

    def require_user
      redirect_to login_path unless current_user
    end
  end

end
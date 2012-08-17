require 'repository'
require 'models/user'

class ChangePassword

  def initialize(current_user)
    @current_user = current_user
  end

  def user
    @current_user
  end

  def run(current_password, new_password, confirm_new_password)
    if @current_user.password == current_password
      if new_password == confirm_new_password
        @current_user.password = new_password
      else
        @current_user.errors.add(:new_password, "New passwords don't match")
      end
    else
      @current_user.errors.add(:current_password, "Current password is incorrect")
    end

    Repository.for(User).save(@current_user)
  end

end

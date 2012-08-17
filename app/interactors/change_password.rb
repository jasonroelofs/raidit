##
# Check that the current_password matches the user and that
# the new password and it's confirmation match and update the
# password on the given User.
#
# Will add errors to User if either of the requirements don't match.
# Returns the updated User object.
# Does not save to the db.
##
class ChangePassword

  def initialize(current_user)
    @current_user = current_user
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

    @current_user
  end

end

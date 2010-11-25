module RolesHelper

  # Define a block that will only get executed if
  # the current logged in user has the given role
  def role(role)
    yield if role?(role)
  end

end

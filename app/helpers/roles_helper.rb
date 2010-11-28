module RolesHelper

  # Define a block that will only get executed if
  # the current logged in user has the given role
  def role(role)
    yield if role?(role)
  end

  # Here as a duplicate of ApplicationController to
  # allow access from Cells.
  def role?(role)
    User.current && User.current.has_role?(role)
  end

end

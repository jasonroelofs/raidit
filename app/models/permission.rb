require 'entity'

class Permission
  include Entity

  attr_accessor :user, :guild, :permissions

  def initialize
    @permissions = []
  end

  def allow(perm)
    (@permissions << perm).uniq!
  end

  def allows?(perm)
    @permissions.include?(perm)
  end

end

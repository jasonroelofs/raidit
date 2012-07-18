require 'entity'

class Raid
  include Entity

  ROLES = %w(tank healer dps).freeze

  attr_accessor :when, :leader, :owner, :where

  attr_accessor :start_at, :invite_at

  def initialize(params = {})
    super
    @role_limits = {}
  end

  ##
  # Define a max number of people a given role
  # is supposed to fill to
  ##
  def set_role_limit(role, limit)
    @role_limits[role] = limit
  end

  def roles
    ROLES
  end

  ##
  # Retrieve the previously set role limit for the
  # given role. If no role limit defined, returns nil
  ##
  def role_limit(role)
    @role_limits[role]
  end

  def has_role?(role)
    ROLES.include?(role.to_s)
  end

  ##
  # Get the max number of characters allowed in this raid
  # according to role limits set above.
  #
  # Returns nil if no role limits set
  ##
  def size
    if @role_limits.any?
      @role_limits.values.inject(0) {|memo, value| memo + value }
    end
  end

end

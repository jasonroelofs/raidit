require 'entity'

class Raid
  include Entity

  attr_accessor :when, :leader, :owner, :where

  attr_accessor :start_at, :invite_at

  attr_reader :roles

  def initialize(params = {})
    super

    @roles = [:tank, :dps, :heal]
    @role_limits = {}
  end

  ##
  # Define a max number of people a given role
  # is supposed to fill to
  ##
  def set_role_limit(role, limit)
    @role_limits[role] = limit
  end

  ##
  # Retrieve the previously set role limit for the
  # given role. If no role limit defined, returns nil
  ##
  def role_limit(role)
    @role_limits[role]
  end
end

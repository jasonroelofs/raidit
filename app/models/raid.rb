class Raid

  attr_reader :id, :when, :leader, :owner, :where

  attr_reader :start_at, :invite_at

  attr_reader :roles

  def initialize(attrs = {})
    @id = attrs[:id]
    @when = attrs[:when]
    @leader = attrs[:leader]
    @owner = attrs[:owner]
    @where = attrs[:where]
    @start_at = attrs[:start_at]
    @invite_at = attrs[:invite_at]

    @roles = [:tank, :dps, :healer]
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

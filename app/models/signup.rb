require 'entity'

class Signup
  include Entity

  attr_accessor :raid, :character, :role

  attr_accessor :state, :user

  def initialize(attrs = {})
    super

    @state = :available
  end

  def available?
    @state == :available
  end

  def accepted?
    @state == :accepted
  end

  def cancelled?
    @state == :cancelled
  end
end

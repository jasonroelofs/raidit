require 'entity'

class Signup
  include Entity

  attr_accessor :raid, :character, :user

  attr_accessor :acceptance_status, :role

  def initialize(attrs = {})
    super

    self.acceptance_status ||= :available
  end

  def character_name
    character ? character.name : ""
  end

  def available?
    acceptance_status == :available
  end

  def accepted?
    acceptance_status == :accepted
  end

  def cancelled?
    acceptance_status == :cancelled
  end
end

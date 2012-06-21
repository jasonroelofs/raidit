class Signup

  attr_reader :raid, :character, :role

  attr_accessor :state, :user

  def initialize(attrs = {})
    @raid = attrs[:raid]
    @character = attrs[:character]
    @role = attrs[:role]
    @user = attrs[:user]
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

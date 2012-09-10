require 'entity'

class Character
  include Entity

  attr_accessor :user, :guild

  attr_accessor :name, :character_class, :is_main

  validates_presence_of :name

  def main?
    !!@is_main
  end

  def guild_id
    guild.try(:id)
  end

end

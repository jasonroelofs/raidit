class Character
  include MongoMapper::Document

  key :name,  String
  key :class_name, String
  key :race,  String
  key :user_id, ObjectId
  key :guild_id, ObjectId
  key :is_main, Boolean

  key :level, Integer

  # tank, healer, or dps
  key :main_role, String
  key :off_role, String

  belongs_to :user
  belongs_to :guild

  many :loot_history_entries
  key :loot_current_amount, Float, :default => 0.0
  key :loot_lifetime_amount, Float, :default => 0.0

  timestamps!

  attr_accessible :main_role

  # All characters not currently assigned to a user
  scope :unchosen, :user_id => nil

  # All characters currently assigned to a user
  scope :assigned, :user_id => {"$ne" => nil}

  # Convert the class of this character to something
  # we use in choosing what icon to show
  def class_slug
    self.class_name.downcase.gsub(" ", "")
  end

  # Given a list of history entries from the loot file,
  # and add a new LootHistoryEntry for ones we don't have yet
  def save_new_history(history)
    newest = self.loot_history_entries.last

    self.loot_history_entries.each do |entry|
      newest = entry if entry.timestamp > newest.timestamp
    end

    history.each do |entry|
      if newest.nil? || entry["timestamp"] > newest.timestamp
        self.loot_history_entries << LootHistoryEntry.new(entry)
      end
    end
  end

end

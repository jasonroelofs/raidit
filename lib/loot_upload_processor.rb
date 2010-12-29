class LootUploadProcessor

  # Run by cron, this grabs every newly uploaded
  # loot file and processes the history, adding appropriate
  # entries to characters
  def self.process_new_uploads!
    # For each file, in order of uploaded (oldest -> newest) who aren't yet processed
    # Get guild
    # Download file
    # For each assigned character in the guild
    #  - Find history for that character
    #  - Build the list of entries that are newer than our saved history
    #  - Enter each history line to the character's loot_history_entry
    #  - Update current and lifetime values
    # Mark file as processed
  end

end

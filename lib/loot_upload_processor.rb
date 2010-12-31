require 'open-uri'

class LootUploadProcessor

  # Run by cron, this grabs every newly uploaded
  # loot file and processes the history, adding appropriate
  # entries to characters
  def self.process_new_uploads!
    # For each file, in order of uploaded (oldest -> newest) who aren't yet processed
    LootUpload.unprocessed.each do |loot_upload|
      begin
        # Get guild and loot system
        guild = loot_upload.guild
        loot_system = guild.loot_system

        # Process the upload, returns a LootData object
        loot_file = download_loot_file(loot_upload)
        loot_data = loot_system.process_file(loot_file)

        # For each assigned character in the guild
        guild.characters.assigned.each do |char|
          #  - Build the list of entries that are newer than our saved history
          history = loot_data.get_history_for(char.name)
          char.save_new_history(history)

          #  - Update current and lifetime values
          char.loot_current_amount = loot_data.current_amount_for(char.name)
          char.loot_lifetime_amount = loot_data.lifetime_amount_for(char.name)
          char.save
        end

        # Mark file as processed
        loot_upload.processed = true
        loot_upload.save
      rescue => ex
        if Rails.env.production?
          HoptoadNotifier.notify({
            :error_class => "Loot Upload Processor Error",
            :error_message => "Problem processing upload: #{ex.message}",
            :backtrace => ex.backtrace          
          })
        else
          raise ex
        end
      end
    end
  end

  def self.download_loot_file(loot_upload)
    temp = Tempfile.new("loot_upload_#{Process.pid}")
    open(loot_upload.loot_file_url) do |f|
      temp.write(f.read)
    end       
    # Re-open the file to put ourselves in Read mode
    temp.open
    temp
  end
end

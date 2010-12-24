desc "Cron job, called by Heroku, daily"
task :cron => :environment do
  # TODO Make sure this doesn't run into
  # request limits when we get more than one guild
  Guild.all.each do |guild|
    guild.fill_characters_from_armory!
  end

  LootUploadProcessor.process_new_uploads!
end

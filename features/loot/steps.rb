When /^the loot upload processor runs$/ do
  LootUploadProcessor.process_new_uploads!
end

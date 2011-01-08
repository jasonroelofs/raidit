# encoding: utf-8

class LootFileUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader:
  storage :s3

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "loot_files/#{model.guild.id}/#{model.id}"
  end

  def cache_dir
    Rails.root.join("tmp", "loot_files")
  end

end

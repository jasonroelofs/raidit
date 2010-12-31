class LootUpload
  include MongoMapper::Document
  extend CarrierWave::Mount

  ##
  # See +CarrierWave::Mount#mount_uploader+ for documentation
  ##
  def self.mount_uploader(column, uploader, options={}, &block)
    # We need to set the mount_on column (or key in MongoMapper's case)
    # since MongoMapper will attempt to set the filename on 
    # the uploader instead of the file on a Document's initialization.
    options[:mount_on] ||= "#{column}_filename"
    key options[:mount_on]
    
    super
    alias_method :read_uploader, :[]
    alias_method :write_uploader, :[]=
    after_save "store_#{column}!".to_sym
    before_save "write_#{column}_identifier".to_sym
    after_destroy "remove_#{column}!".to_sym
  end

  mount_uploader :loot_file, LootFileUploader

  key :guild_id
  belongs_to :guild

  key :processed, Boolean, :default => false

  timestamps!

  def self.unprocessed
    where(:processed => false).order(:created_at => "DESC")
  end
end

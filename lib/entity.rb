require 'active_model'

# Copied from ActiveModel::Model in Rails master HEAD
module Entity
  def self.included(base) #:nodoc:
    base.class_eval do
      extend  ActiveModel::Naming
      include ActiveModel::Validations
      include ActiveModel::Conversion
    end
  end

  attr_accessor :id

  def initialize(params={})
    params.each do |attr, value|
      self.public_send("#{attr}=", value)
    end if params
  end


  ##
  # From ActiveRecord::Base
  ##
  def ==(other_entity)
    super ||
      other_entity.instance_of?(self.class) &&
      id.present? &&
      other_entity.id == id
  end
  alias :eql? :==

  ##
  # Required activemodel API calls
  ##

  def persisted?
    !!self.id
  end
end

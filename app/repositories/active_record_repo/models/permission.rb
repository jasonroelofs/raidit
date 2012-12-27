module ActiveRecordRepo::Models
  class Permission < ActiveRecord::Base
    belongs_to :user
    belongs_to :guild
  end
end

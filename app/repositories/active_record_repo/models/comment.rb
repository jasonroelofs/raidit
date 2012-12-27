module ActiveRecordRepo::Models
  class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :signup

    def self.for_signup(signup)
      where(:signup_id => signup.id)
    end
  end
end

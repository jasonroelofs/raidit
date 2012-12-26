module ActiveRecordRepo::Models
  class Guild < ActiveRecord::Base

    def self.first_by_name(name)
      where(:name => name).first
    end

    def self.search_by_name(query)
      where(["name LIKE ?", "%#{query}%"])
    end

  end
end

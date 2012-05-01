require 'repository'

class FindGuild

  attr_accessor :by_id, :by_name

  def run
    repo = Repository.for(Guild)

    if @by_id
      repo.find @by_id
    elsif @by_name
      repo.find_by_name @by_name
    end
  end
end
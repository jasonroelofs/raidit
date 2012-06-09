class RaidsController < ApplicationController

  requires_user

  def index
    action = FindRaidsForUser.new current_user
    @raids = action.run
  end

end

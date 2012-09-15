class GuildsController < ApplicationController

  requires_user

  respond_to :json

  def index
    @guilds = ListGuilds.by_partial_name(params[:q])
    respond_with @guilds
  end

end

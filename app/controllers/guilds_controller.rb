class GuildsController < ApplicationController

  requires_user

  respond_to :json

  def index
    @guilds = ListGuilds.by_partial_name(params[:q])
    respond_with @guilds
  end

  ##
  # Change the currently viewed guild to the one given in params[:id]
  ##
  def make_current
    if guild = FindGuild.by_user_and_id(current_user, params[:id].to_i)
      session[:current_guild_id] = guild.id
    end

    redirect_to params[:back_to] || root_path
  end

end

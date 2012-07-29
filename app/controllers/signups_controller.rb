class SignupsController < ApplicationController

  requires_user

  # /raids/:raid_id/signups
  #
  # Sign a character up to the given Raid
  def create
    raid = FindRaid.by_id params[:raid_id].to_i
    character = FindCharacter.by_id params[:character_id].to_i

    action = SignUpToRaid.new(current_user)
    action.run(raid, character, params[:role])

    redirect_to raid_path(raid)
  end

  # /signups/:id/:command
  #
  # Run +command+ on the given signup
  def update
    signup = FindSignup.by_id(params[:id].to_i)
    action = UpdateSignup.new current_user, current_guild
    action.run signup, params[:command]

    redirect_to raid_path(signup.raid)
  end

end

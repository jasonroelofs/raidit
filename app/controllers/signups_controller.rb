class SignupsController < ApplicationController

  requires_user

  # /raids/:raid_id/signups
  #
  # Sign a character up to the given Raid
  def create
    raid_id = params[:raid_id].to_i

    action = SignUpToRaid.new(current_user)
    action.run(raid_id, params[:character].to_i)

    redirect_to raid_path(raid_id)
  end

  # /signups/:id/:command
  #
  # Run +command+ on the given signup
  def update
    signup = Repository.for(Signup).find params[:id].to_i
    action = UpdateSignup.new current_user, signup
    action.run params[:command]

    redirect_to raid_path(signup.raid)
  end

end

class SignupsController < ApplicationController

  requires_user

  def create
    raid_id = params[:raid_id].to_i

    action = SignUpToRaid.new(current_user)
    action.run(raid_id, params[:character].to_i)

    redirect_to raid_path(raid_id)
  end

end

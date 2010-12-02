class AdminController < ApplicationController
  before_filter :authenticate_user!
  requires_permission :admin

  # Users management starting page
  def index
  end

  # Raids history page
  def raids
  end

  # Log / Events page
  def logs
  end

  # API information page
  def api
  end

end

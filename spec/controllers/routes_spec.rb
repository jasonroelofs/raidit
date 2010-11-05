require 'spec_helper'

describe ApplicationController do

  # WTF? Rspec cares about what directory I'm running from?

  it "handles routes" do
    {:get => "/"}.should route_to(:controller => "calendar", :action => "show")
  end

end

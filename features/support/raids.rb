Before("@raids") do
  guild = Guild.find_by_name("Exiled")
  Factory(:raid, :guild => guild, :location => "ICC", :date => Date.parse("2010/11/01"), :start_time => "8:00 pm", :invite_time => "7:45 pm")
  Factory(:raid, :guild => guild, :location => "Baradin Hold", :date => Date.parse("2010/11/12"), :start_time => "8:00 pm", :invite_time => "7:45 pm")
  Factory(:raid, :guild => guild, :location => "Ken's Mom", :date => Date.parse("2010/12/20"), :start_time => "11:13 am", :invite_time => "11:14 am")
end

Before("@event_logs") do
  raid = Raid.find_by_location("ICC")
  raid.event_logs << EventLog.new(:who => "Mage-man", :event => "accepted Warrior-girl", :when => Time.parse("2010/10/30 4:40 am EST"))
  raid.save
end

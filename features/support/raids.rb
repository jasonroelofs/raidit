Before("@raids") do
  guild = Guild.find_by_name("Exiled")
  Factory(:raid, :guild => guild, :location => "ICC", :date => Date.parse("2010/11/01"), :start_time => "8:00 pm", :invite_time => "7:45 pm")
  Factory(:raid, :guild => guild, :location => "Baradin Hold", :date => Date.parse("2010/11/12"), :start_time => "8:00 pm", :invite_time => "7:45 pm")
  Factory(:raid, :guild => guild, :location => "Ken's Mom", :date => Date.parse("2010/12/20"), :start_time => "11:13 am", :invite_time => "11:14 am")
end

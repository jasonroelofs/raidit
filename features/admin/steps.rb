When %r{^I edit "([^"]*)"$} do |email|
  When %|I follow "Edit" within "#user_#{User.find_by_email(email).id}"|
end

Then %r{^"([^"]*)" should( not)? be a (admin|raid leader|user)$} do |email, not_be, role|
  u = User.find_by_email(email)
  
  if not_be
    u.role.should_not == role
  else
    u.role.should == role
  end
end

When %r{^I unassociate the character "([^"]*)"$} do |char_name|
  c = Character.find_by_name(char_name)
  When %|I follow "Unassociate" within "#character_#{c.id}"|
end

Then "I should see the following raids" do |table|
  table.hashes.each do |row|
    page.should have_css("td", :text => row[:date])
    page.should have_css("td", :text => row[:invite])
    page.should have_css("td", :text => row[:start])
    page.should have_css("td", :text => row[:name])
  end
end

When %r{^I follow "([^"]*)" for the raid to "([^"]*)"$} do |link, location|
  r = Raid.find_by_location(location)
  And %|I follow "#{link}" within "tr#raid_#{r.id}"|
end

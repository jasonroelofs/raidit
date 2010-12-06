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


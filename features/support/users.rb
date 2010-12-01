Before("@users") do
  {
    "jason@raidit.org" => "admin",
    "leader@raidit.org" => "raid_leader",
    "user@raidit.org" => "user"
  }.each do |email, role|
    u = User.create(:email => email,
                    :password => "testingzoo", :password_confirmation => "testingzoo")
    u.update_attribute(:role, role)
  end
end

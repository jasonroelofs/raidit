Before("@users") do
  {
    "jason@raidit.org" => "admin",
    "leader@raidit.org" => "raid_leader",
    "user@raidit.org" => "user"
  }.each do |email, role|
    Factory(:user, :email => email, :password => "testingzoo", :password_confirmation => "testingzoo", :role => role)
  end
end

Before("@characters") do
  jason = User.find_by_email("jason@raidit.org")
  leader = User.find_by_email("leader@raidit.org")
  user = User.find_by_email("user@raidit.org")
  guild = Guild.find_by_name("Exiled")

  Factory(:character, :user => jason, :guild => guild, :name => "Mage", :class_name => "Mage", :race => "Troll", :level => 80, :main_role => "dps", :is_main => true)
  Factory(:character, :user => jason, :guild => guild, :name => "DK", :class_name => "Death Knight", :race => "Troll", :level => 80, :main_role => "tank")

  Factory(:character, :user => leader, :guild => guild, :name => "Warrior", :class_name => "Warrior", :race => "Tauren", :level => 80, :main_role => "tank")

  Factory(:character, :user => user, :guild => guild, :name => "Priest", :class_name => "Priest", :race => "Tauren", :level => 80, :main_role => "healer", :is_main => true)
end

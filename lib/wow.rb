module Wow

  AvailableRoles = {
    "Warrior" => %w(dps tank),
    "Paladin" => %w(dps tank healer),
    "Hunter" => %w(dps),
    "Rogue" => %w(dps),
    "Priest" => %w(dps healer),
    "Death Knight" => %w(dps tank),
    "Shaman" => %w(dps healer),
    "Mage" => %w(dps),
    "Warlock" => %w(dps),
    "Druid" => %w(dps healer tank)
  }

  RoleValueMap = {
    "dps" => "DPS",
    "healer" => "Healer",
    "tank" => "Tank"
  }

end

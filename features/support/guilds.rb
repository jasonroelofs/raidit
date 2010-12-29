Before do
  Guild.create :name => "Exiled", :region => "US", :realm => "Detheroc"
end

Before("@ni_karma") do
  g = Guild.find_by_name("Exiled")
  g.loot_type = "NiKarma"
  g.save
end

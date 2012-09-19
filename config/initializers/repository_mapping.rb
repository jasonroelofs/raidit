require_dependency 'repositories/in_memory'

Raidit::Application.configure do

  config.to_prepare do
    Repository.configure(
      "User"        => InMemory::UserRepo.new,
      "Guild"       => InMemory::GuildRepo.new,
      "Character"   => InMemory::CharacterRepo.new,
      "Raid"        => InMemory::RaidRepo.new,
      "Signup"      => InMemory::SignupRepo.new,
      "Permission"  => InMemory::PermissionRepo.new
    )

    # Set up our seed data for the development setup
    if Rails.env.development?
      Repository.for(Guild).save(
        exiled = Guild.new(:name => "Exiled", :region => "US", :server => "Detheroc")
      )

      Repository.for(Guild).save(
        mind_crush = Guild.new(:name => "Mind Crush", :region => "US", :server => "Kil'Jaeden")
      )

      Repository.for(User).save(
        jason = User.new(:login => "jason", :password => "password")
      )

      Repository.for(User).save(
        raider = User.new(:login => "raider", :password => "password")
      )

      Repository.for(Character).save(
        weemuu = Character.new(:name => "Weemuu", :user => jason,
                               :character_class => "mage", :guild =>  exiled)
      )

      Repository.for(Character).save(
        wonko = Character.new(:name => "Wonko",
          :user => jason, :character_class => "warrior", :guild => mind_crush)
      )

      Repository.for(Character).save(
        weemoo = Character.new(:name => "Weemoo",
          :user => jason, :character_class => "shaman", :guild => mind_crush)
      )

      Repository.for(Character).save(
        weemoo = Character.new(:name => "Pandy",
          :user => jason, :character_class => "druid")
      )

      Repository.for(Character).save(
        phouchg = Character.new(:name => "Phouchg",
          :user => raider, :character_class => "hunter", :guild => exiled)
      )

      Repository.for(Permission).save(
        Permission.new(:user => jason, :guild => exiled,
                       :permissions => Permission::RAID_LEADER)
      )

      (1.week.ago.to_date..2.weeks.from_now.to_date).each do |day|
        raid = Raid.new :when => day, :owner => exiled, :where => "ICC",
          :start_at => Time.parse("20:00"), :invite_at => Time.parse("19:30")

        raid.set_role_limit :tank, (rand * 5).to_i
        raid.set_role_limit :dps, (rand * 20).to_i
        raid.set_role_limit :healer, (rand * 5).to_i

        Repository.for(Raid).save(raid)

        SignUpToRaid.new(jason).run raid, weemuu, "dps"
        SignUpToRaid.new(raider).run raid, phouchg, "healer"
      end
    end
  end

end

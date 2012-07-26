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
      Repository.for(User).save(
        jason = User.new(:login => "jason", :password => "password")
      )

      Repository.for(User).save(
        raider = User.new(:login => "raider", :password => "password")
      )

      Repository.for(Character).save(
        weemuu = Character.new(:name => "Weemuu", :game => "wow", :server => "Kil'Jaeden",
          :region => "US", :user => jason)
      )

      Repository.for(Character).save(
        phouchg = Character.new(:name => "Phouchg", :game => "wow", :server => "Kil'Jaeden",
          :region => "US", :user => raider)
      )

      (1.week.ago.to_date..2.weeks.from_now.to_date).each do |day|
        raid = Raid.new :when => day, :owner => jason, :where => "ICC",
          :start_at => Time.parse("20:00"), :invite_at => Time.parse("19:30")

        raid.set_role_limit :tank, (rand * 5).to_i
        raid.set_role_limit :dps, (rand * 20).to_i
        raid.set_role_limit :heal, (rand * 5).to_i

        Repository.for(Raid).save(raid)

        SignUpToRaid.new(jason).run raid, weemuu, "dps"
        SignUpToRaid.new(raider).run raid, phouchg, "healer"
      end
    end
  end

end

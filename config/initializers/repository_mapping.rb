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

      jason.onboarded! :characters

      Repository.for(Character).save(
        weemuu = Character.new(:name => "Weemuu", :game => "wow", :server => "Kil'Jaeden",
          :region => "US", :user => jason)
      )

      (Date.today..2.weeks.from_now.to_date).each do |day|
        raid = Raid.new :when => day, :owner => jason, :where => "ICC",
          :start_at => Time.parse("20:00"), :invite_at => Time.parse("19:30")

        Repository.for(Raid).save(raid)
      end
    end
  end

end

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
        User.new(:login => "jason", :password => "password")
      )
    end
  end

end
require_dependency 'repositories/in_memory'

Raidit::Application.configure do

  config.to_prepare do
    Repository.configure(
      "User" => InMemory::UserRepo.new,
      "Guild" => InMemory::GuildRepo.new,
      "Character" => InMemory::CharacterRepo.new,
      "Raid" => InMemory::RaidRepo.new,
      "Signup" => InMemory::SignupRepo.new,
      "Permission" => InMemory::PermissionRepo.new
    )
  end

end
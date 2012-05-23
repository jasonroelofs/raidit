require 'repositories/in_memory'

ActiveSupport.on_load(:after_initialize) do
  Repository.configure(
    "User" => InMemory::UserRepo.new,
    "Guild" => InMemory::GuildRepo.new,
    "Character" => InMemory::CharacterRepo.new,
    "Raid" => InMemory::RaidRepo.new,
    "Signup" => InMemory::SignupRepo.new,
    "Permission" => InMemory::PermissionRepo.new
  )
end

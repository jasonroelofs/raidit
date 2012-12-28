module ActiveRecordRepo
  class BaseRepo
    def initialize(ar_class, domain_class, raw_attributes = [], associations = {})
      @ar_class = ar_class
      @domain_class = domain_class
      @raw_attributes = [:id, raw_attributes].flatten
      @associations = associations
    end

    def find(id)
      find_one @ar_class.find(id)
    end

    def save(domain_model)
      ar_model = convert_to_ar_model(domain_model)
      ar_model.save.tap do |success|
        domain_model.id = ar_model.id if success
      end
    end

    protected

    def find_one(query)
      convert_to_domain query
    end

    def find_all(query)
      convert_all_to_domain query
    end

    def find_or_initialize(object_id)
      @ar_class.where(:id => object_id).first_or_initialize
    end

    def convert_all_to_domain(records)
      domain_models = []

      records.find_each do |record|
        domain_models << convert_to_domain(record)
      end

      domain_models
    end

    def convert_to_domain(record)
      @domain_class.new map_attributes_and_associations(record) if record
    end

    def map_attributes_and_associations(ar_record)
      attributes_hash = {}
      @raw_attributes.each do |attribute|
        attributes_hash[attribute] = ar_record.send(attribute)
      end

      @associations.each do |association, association_repo|
        attributes_hash[association] = association_repo.convert_to_domain(
          ar_record.send(association))
      end

      attributes_hash
    end

    def convert_to_ar_model(domain_model)
      return unless domain_model
      if domain_model.persisted?
        @ar_class.find(domain_model.id).tap do |ar_model|
          @raw_attributes.each do |attribute|
            ar_model.send("#{attribute}=", domain_model.send(attribute))
          end

          @associations.each do |association, association_repo|
            ar_model.send("#{association}=", association_repo.convert_to_ar_model(
              domain_model.send(association)))
          end
        end
      else
        attributes_hash = {}
        @raw_attributes.each do |attribute|
          attributes_hash[attribute] = domain_model.send(attribute)
        end

        @associations.each do |association, association_repo|
          attributes_hash[association] = association_repo.convert_to_ar_model(
            domain_model.send(association))
        end

        @ar_class.new(attributes_hash)
      end
    end
  end

  class GuildRepo < BaseRepo
    def initialize
      super(ActiveRecordRepo::Models::Guild, ::Guild, [:name, :region, :server])
    end

    def find_by_name(name)
      find_one @ar_class.first_by_name(name)
    end

    def search_by_name(query)
      find_all @ar_class.search_by_name(query)
    end
  end

  class UserRepo < BaseRepo
    def initialize
      super(ActiveRecordRepo::Models::User, ::User, [:login, :email, :password_hash, :login_tokens])
    end

    def find_by_login(login)
      find_one @ar_class.first_by_login(login)
    end

    def find_by_login_token(type, token)
      find_one @ar_class.first_by_login_token(type, token)
    end
  end

  class CharacterRepo < BaseRepo
    def initialize
      super(ActiveRecordRepo::Models::Character, ::Character,
            [:name, :character_class, :is_main],
            {:user => UserRepo.new, :guild => GuildRepo.new})
    end

    def find_by_user_and_id(user, id)
      find_one @ar_class.first_by_user_and_id(user, id)
    end

    def find_all_for_user(user)
      find_all @ar_class.for_user(user)
    end

    def find_main_character(user, guild)
      find_one @ar_class.user_main_in_guild(user, guild)
    end

    def find_all_in_guild(guild)
      find_all @ar_class.in_guild(guild)
    end

    def find_all_for_user_in_guild(user, guild)
      find_all @ar_class.for_user_in_guild(user, guild)
    end
  end

  class RaidRepo < BaseRepo
    def initialize
      super(ActiveRecordRepo::Models::Raid, ::Raid,
            [:role_limits, :when, :where, :start_at, :invite_at],
            {:owner => GuildRepo.new})
    end

    def find_raids_for_guild(guild)
      find_all @ar_class.for_guild(guild)
    end

    def find_raids_for_guild_and_day(guild, day)
      find_all @ar_class.for_guild_and_day(guild, day)
    end
  end

  class SignupRepo < BaseRepo
    def initialize
      super(ActiveRecordRepo::Models::Signup, ::Signup,
            [:acceptance_status, :role],
            {:raid => RaidRepo.new, :user => UserRepo.new}) #:character
    end

    def find_all_for_raid(raid)
      find_all @ar_class.for_raid(raid)
    end

    def find_all_for_user_and_raid(user, raid)
      find_all @ar_class.for_user_and_raid(user, raid)
    end

    def find_by_raid_and_id(raid, id)
      find_one @ar_class.first_by_id_and_raid(id, raid)
    end
  end

  class PermissionRepo < BaseRepo
    def initialize
      super(ActiveRecordRepo::Models::Permission, ::Permission,
            [:permissions],
            {:user => UserRepo.new, :guild => GuildRepo.new})
    end

    def find_by_user_and_guild(user, guild)
      find_one @ar_class.first_by_user_and_guild(user, guild)
    end
  end

  class CommentRepo < BaseRepo
    def initialize
      super(ActiveRecordRepo::Models::Comment, ::Comment,
            [:comment],
            {:user => UserRepo.new, :signup => SignupRepo.new})
    end

    def find_all_by_signup(signup)
      find_all @ar_class.for_signup(signup)
    end
  end
end

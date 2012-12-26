module ActiveRecordRepo
  class BaseRepo
    def initialize(ar_class, domain_class, mapped_attributes = [])
      @ar_class = ar_class
      @domain_class = domain_class
      @mapped_attributes = mapped_attributes
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
      convert_to_domain query, @domain_class
    end

    def find_all(query)
      convert_all_to_domain query, @domain_class
    end

    def convert_to_domain(record, domain_class)
      domain_class.new record.attributes if record
    end

    def convert_all_to_domain(records, domain_class)
      domain_models = []

      records.find_each do |record|
        domain_models << convert_to_domain(record, domain_class)
      end

      domain_models
    end

    def convert_to_ar_model(domain_model)
      if domain_model.persisted?
        @ar_class.find(domain_model.id).tap do |ar_model|
          @mapped_attributes.each do |attr|
            ar_model[attr] = domain_model.send(attr)
          end
        end
      else
        attrs = @mapped_attributes.inject({}) do |hash, attr|
          hash[attr] = domain_model.send(attr)
          hash
        end

        @ar_class.new(attrs)
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

  class CharacterRepo
    def find_by_user_and_id(user, id)
      find_one {|c|
        c.id == id &&
        c.user.id == user.id
      }
    end

    def find_all_for_user(user)
      find_all {|c| c.user == user }
    end

    def find_main_character(user, guild)
      find_one {|c|
        c.user == user &&
          c.guild == guild &&
          c.main?
      }
    end

    def find_all_in_guild(guild)
      find_all {|c| c.guild == guild }
    end

    def find_all_for_user_in_guild(user, guild)
      find_all { |char|
        char.user == user && char.guild == guild
      }
    end
  end

  class RaidRepo
    def find_raids_for_guild(guild)
      find_all {|r| r.owner == guild }
    end

    def find_raids_for_guild_and_day(guild, day)
      raids = find_raids_for_guild(guild)
      if day
        raids.select {|raid| raid.when == day }
      else
        raids
      end
    end
  end

  class SignupRepo
    def find_all_for_raid(raid)
      find_all {|s| s.raid == raid }
    end

    def find_all_for_user_and_raid(user, raid)
      find_all {|s|
        s.raid == raid && s.user == user
      }
    end

    def find_by_raid_and_id(raid, id)
      find_one {|s|
        s.id == id && s.raid == raid
      }
    end
  end

  class PermissionRepo
    def find_by_user_and_guild(user, guild)
      find_one {|perm|
        perm.user == user && perm.guild == guild
      }
    end
  end

  class CommentRepo
    def find_all_by_signup(signup)
      find_all {|c|
        c.signup == signup
      }
    end
  end
end

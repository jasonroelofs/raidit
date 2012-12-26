module ActiveRecordRepo::Models
  class User < ActiveRecord::Base

    serialize :login_tokens, ActiveRecord::Coders::Hstore

    def self.first_by_login(login)
      where(:login => login).first
    end

    def self.first_by_login_token(token_type, token_value)
      where(["login_tokens -> ? = ?", token_type, token_value]).first
    end

  end
end

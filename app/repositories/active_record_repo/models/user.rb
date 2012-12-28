module ActiveRecordRepo::Models
  class User < ActiveRecord::Base

    serialize :login_tokens, ActiveRecord::Coders::Hstore
    after_initialize :convert_login_tokens

    def self.first_by_login(login)
      where(:login => login).first
    end

    def self.first_by_login_token(token_type, token_value)
      where(["login_tokens -> ? = ?", token_type, token_value]).first
    end

    protected

    def convert_login_tokens
      self.login_tokens = self.login_tokens.try(:with_indifferent_access)
    end

  end
end

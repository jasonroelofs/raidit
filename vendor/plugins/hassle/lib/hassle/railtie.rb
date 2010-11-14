require 'rails'

module HassleRails
  class Railtie < Rails::Railtie
    initializer :after_initialize do
      require 'rack'
      require 'sass'
      require 'sass/plugin'

      if (defined? Rails.env ? Rails.env.production? : "production" == RAILS_ENV)
        if defined? Rails.configuration && defined? Rails.configuration.middleware
          Rails.configuration.middleware.use(Hassle)
        elsif defined? ActionController::Dispatcher && defined? ActionController::Dispatcher.middleware
          ActionController::Dispatcher.middleware.use Hassle
        end  
      end
    end
  end
end

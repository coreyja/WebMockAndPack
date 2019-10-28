# frozen_string_literal: true

module Webpackandmock
  class Railtie < ::Rails::Railtie
    initializer 'webpackandmock.replace_webpacker_proxy', after: 'webpacker.proxy' do |app|
      my_proxy = Class.new(Webpacker::DevServerProxy) do
        def perform_request(env)
          WebMock.disable!
          super.tap { WebMock.enable! }
        end
      end

      swap_with = if Rails::VERSION::MAJOR >= 5
                    Webpacker::DevServerProxy
                  else
                    'Webpacker::DevServerProxy'
                  end

      app.middleware.swap swap_with, my_proxy
    end
  end
end

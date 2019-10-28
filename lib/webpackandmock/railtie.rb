# frozen_string_literal: true

require 'webmock'
require 'webpacker'

module BypassWebmock
  def perform_request(env)
    WebMock.disable!.tap { Rails.logger.info 'Disabled webmock' }
    super.tap { WebMock.enable!.tap { Rails.logger.info 'Enabled webmock' } }
  end
end

module Webpackandmock
  class Railtie < ::Rails::Railtie
    initializer 'myapp.replace_webpacker_proxy', after: 'webpacker.proxy' do |app|
      my_proxy = Class.new(Webpacker::DevServerProxy) do
        include BypassWebmock
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

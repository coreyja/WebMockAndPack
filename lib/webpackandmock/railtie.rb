# frozen_string_literal: true

require 'webmock'
require 'webpacker'

module BypassWebmock
  mattr_accessor :times_disabled

  self.times_disabled = 0

  def perform_request(env)
    WebMock.disable!.tap { self.times_disabled += 1 }
    result = super
    self.times_disabled -= 1
    WebMock.enable! if self.times_disabled.zero?
    result
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

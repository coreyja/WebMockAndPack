# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'webmockandpack/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'webmockandpack'
  spec.version     = Webmockandpack::VERSION
  spec.authors     = ['Corey Alexander']
  spec.email       = ['coreyja@gmail.com']
  spec.homepage    = 'http://github.com/coreyja/webmockandpack'
  spec.summary     = 'This make the Webmock and Webpacker gems play nicely together'
  spec.description = 'This make the Webmock and Webpacker gems play nicely together'
  spec.license     = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails'
  spec.add_dependency 'webmock'
  spec.add_dependency 'webpacker'
end

require 'rubygems'
require 'bundler/setup'
require 'dotenv'

Bundler.require

AppEnv = ENV['RACK_ENV'] || 'development'
Dotenv.load

[
  'config/initializers',
  'app/helpers/',
  'app/models/**/*',
  'app/models/',
  'app/services/',
  'app/services/**/*',
  'app/decorators/',
  'app/decorators/**/*',
  'app/delegators/',
  'app/filters/',
  'app/api',
  'app'
].each do |path|
  rbfiles = File.join './', path, '*.rb'
  Dir.glob(rbfiles).each { |file| require file }
end

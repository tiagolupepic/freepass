require 'bundler/setup'
require 'hanami/setup'
require_relative '../lib/freepass'
require_relative '../apps/web/application'

Hanami.configure do
  mount Web::Application, at: '/'
end

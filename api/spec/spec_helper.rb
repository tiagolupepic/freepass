ENV["RACK_ENV"] = 'test'

require File.expand_path("../../config/boot", __FILE__)
require 'rack/test'
require 'factory_girl'
require 'database_cleaner'
require 'faker'
require 'timecop'
require 'vcr'

factories_path = '/spec/factories'

FactoryGirl.factories.clear
FactoryGirl.definition_file_paths = [factories_path]
FactoryGirl.find_definitions

Dir[File.join(__dir__, "support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryGirl::Syntax::Methods

  config.color = true
  config.tty   = true
  config.order = "random"

  def app
    Api
  end

  def response
    last_response
  end

  def json_response
    @json_response ||= JSON.parse(response.body)
  end

  def headers(token, params = nil, headers = {})
    header = {
      'HTTP_AUTHORIZATION' => "Authorization: Token token=#{token}",
      "CONTENT_TYPE"       => "application/json",
    }
    header.merge!({ 'rack.input' => StringIO.new(params.to_json) }) if params.present?
    header.merge!(headers) unless headers.empty?
    header
  end
end

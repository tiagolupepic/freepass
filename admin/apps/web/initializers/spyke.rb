Spyke::Base.connection = Faraday.new(url: ENV['API_URL']) do |c|
  c.request   :json
  c.use       JSONParser
  c.adapter   Faraday.default_adapter
end

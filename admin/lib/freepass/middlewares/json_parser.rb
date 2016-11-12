class JSONParser < Faraday::Response::Middleware
  def parse(body)
    json = MultiJson.load(body, symbolize_keys: true)
    {
      data: json.delete(:errors),
      errors: json.try(:errors) || {},
      metadata: json.try(:metadata) || {}
    }
  end
end

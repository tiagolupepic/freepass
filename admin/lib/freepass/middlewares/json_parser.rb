class JSONParser < Faraday::Response::Middleware
  def parse(body)
    json = MultiJson.load(body, symbolize_keys: true)
    {
      errors: errors(json),
      data: data(json),
      metadata: {}
    }
  end

  private

  def errors(json)
    return {} if json.kind_of? Array or not json.keys.include?(:errors)
    json[:errors]
  end

  def data(json)
    return json if json.kind_of? Array
    json.except(:errors)
  end
end

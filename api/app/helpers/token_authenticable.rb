module TokenAuthenticable
  attr_accessor :current_user

  def authenticate!
    authorization = request.env['HTTP_AUTHORIZATION']
    if authorization
      match = authorization =~ /^^Authorization: Token token=(.*)/m
      credentials = match && { 'token' => $1 }

      unless credentials
        halt_request(400, { error: 'Invalid authorization type' })
        return
      end

      unless token = Token.find_by_number(credentials['token'])
        halt_request(403, { error: 'Access denied' })
        return
      end

      self.current_user = token.user
    else
      halt_request(400, { error: 'Invalid authorization type' })
      return
    end
  end
end

module Web::Controllers::Logout
  class Create
    include Web::Action
    include AdminAuthenticator

    def call(params)
      logout!
      redirect_to routes.new_auth_path
    end
  end
end

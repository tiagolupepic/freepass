module Web::Controllers::Auth
  class Create
    include Web::Action
    include AdminAuthenticator

    def call(params)
      auth = Admin.with('admins/auth').where(password: (params[:auth] || {})[:password]).post
      if auth.success
        login(auth.user)
        redirect_to routes.root_path
      else
        self.status = 422
      end
    end
  end
end

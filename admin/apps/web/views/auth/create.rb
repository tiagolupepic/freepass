module Web::Views::Auth
  class Create
    include Web::View
    layout :login
    template 'auth/new'

    def form
      Form.new(:auth, routes.auths_path)
    end
  end
end

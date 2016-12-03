module Web::Views::Auth
  class New
    include Web::View
    layout :login

    def form
      Form.new(:auth, routes.auths_path)
    end
  end
end

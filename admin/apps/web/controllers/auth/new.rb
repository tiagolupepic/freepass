module Web::Controllers::Auth
  class New
    include Web::Action
    include AdminAuthenticator

    def call(params)
    end
  end
end

module Web::Controllers::Home
  class Index
    include Web::Action
    include AdminAuthenticator
    before :authenticate!

    def call(params)
    end
  end
end

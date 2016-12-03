module Web::Controllers::Hours
  class New
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :hour

    def call(params)
      @hour = Hour.new
    end
  end
end

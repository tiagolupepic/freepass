module Web::Controllers::Hours
  class Edit
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :hour

    def call(params)
      @hour = Hour.find(params[:id])
    end
  end
end

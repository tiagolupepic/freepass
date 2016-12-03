module Web::Controllers::Hours
  class Search
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    accept :html, :json
    expose :hours

    def call(params)
      @hours = Hour.where(q: params[:q])
    end
  end
end

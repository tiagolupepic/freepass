module Web::Controllers::Periods
  class Search
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    accept :html, :json
    expose :periods

    def call(params)
      @periods = Period.where(q: params[:q])
    end
  end
end

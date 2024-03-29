module Web::Controllers::Users
  class Search
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    accept :html, :json
    expose :users

    def call(params)
      @users = User.where(q: params[:q])
    end
  end
end

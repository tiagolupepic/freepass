module Web::Controllers::Users
  class Index
    include Web::Action
    include AdminAuthenticator
    before :authenticate!

    expose :users

    def call(params)
      @users = params[:q].present? ? User.where(q: params[:q]) : User.all
    end
  end
end

module Web::Controllers::Users
  class New
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :user

    def call(params)
      @user = User.new
    end
  end
end

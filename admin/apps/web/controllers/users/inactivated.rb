module Web::Controllers::Users
  class Inactivated
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :user

    def call(params)
      @user = User.find(params[:id])

      if @user.put(:deactivated)
        redirect_to routes.users_path
      else
        self.status = 422
      end
    end
  end
end

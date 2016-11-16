module Web::Controllers::Users
  class Update
    include Web::Action
    expose :user

    def call(params)
      @user = User.find(params[:id])

      if @user.update_attributes(params[:user])
        redirect_to routes.user_path(@user.id)
      else
        self.status = 422
      end
    end
  end
end

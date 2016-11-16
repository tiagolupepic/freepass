module Web::Controllers::Users
  class Create
    include Web::Action
    expose :user

    def call(params)
      @user = User.create(params[:user])

      if @user.persisted?
        redirect_to routes.user_path(@user.id)
      else
        self.status = 422
      end
    end
  end
end

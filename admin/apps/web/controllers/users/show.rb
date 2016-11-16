module Web::Controllers::Users
  class Show
    include Web::Action
    expose :user

    def call(params)
      @user = User.find(params[:id])
    end
  end
end

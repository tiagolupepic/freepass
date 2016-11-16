module Web::Controllers::Users
  class Destroy
    include Web::Action

    def call(params)
      user = User.find(params[:id])
      user.destroy
      redirect_to routes.users_path
    end
  end
end

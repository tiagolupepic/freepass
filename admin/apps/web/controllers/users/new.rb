module Web::Controllers::Users
  class New
    include Web::Action
    expose :user

    def call(params)
      @user = User.new
    end
  end
end

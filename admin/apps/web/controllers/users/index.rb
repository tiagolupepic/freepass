module Web::Controllers::Users
  class Index
    include Web::Action
    expose :users

    def call(params)
      @users = User.all
    end
  end
end

module Web::Controllers::Hours
  class Create
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :hour

    def call(params)
      @hour = Hour.create(params[:hour])

      if @hour.persisted?
        redirect_to routes.hour_path(@hour.id)
      else
        self.status = 422
      end
    end
  end
end

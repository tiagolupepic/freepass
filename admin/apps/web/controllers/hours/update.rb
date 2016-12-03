module Web::Controllers::Hours
  class Update
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :hour

    def call(params)
      @hour = Hour.find(params[:id])

      if @hour.update_attributes(params[:hour])
        redirect_to routes.hour_path(@hour.id)
      else
        self.status = 422
      end
    end
  end
end

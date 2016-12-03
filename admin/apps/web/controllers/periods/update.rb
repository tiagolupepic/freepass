module Web::Controllers::Periods
  class Update
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :period

    def call(params)
      @period = Period.find(params[:id])

      if @period.update_attributes(params[:period])
        redirect_to routes.period_path(@period.id)
      else
        self.status = 422
      end
    end
  end
end

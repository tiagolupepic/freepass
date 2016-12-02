module Web::Controllers::Periods
  class Create
    include Web::Action
    expose :period

    def call(params)
      @period = Period.create(params[:period])

      if @period.persisted?
        redirect_to routes.period_path(@period.id)
      else
        self.status = 422
      end
    end
  end
end

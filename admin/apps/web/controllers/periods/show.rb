module Web::Controllers::Periods
  class Show
    include Web::Action
    expose :period

    def call(params)
      @period = Period.find(params[:id])
    end
  end
end

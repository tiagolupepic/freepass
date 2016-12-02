module Web::Controllers::Periods
  class Edit
    include Web::Action
    expose :period

    def call(params)
      @period = Period.find(params[:id])
    end
  end
end

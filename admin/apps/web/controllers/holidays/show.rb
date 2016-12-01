module Web::Controllers::Holidays
  class Show
    include Web::Action
    expose :holiday

    def call(params)
      @holiday = Holiday.find(params[:id])
    end
  end
end

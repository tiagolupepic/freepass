module Web::Controllers::Holidays
  class Edit
    include Web::Action
    expose :holiday

    def call(params)
      @holiday = Holiday.find(params[:id])
    end
  end
end

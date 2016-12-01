module Web::Controllers::Holidays
  class Create
    include Web::Action
    expose :holiday

    def call(params)
      @holiday = Holiday.create(params[:holiday])

      if @holiday.persisted?
        redirect_to routes.holiday_path(@holiday.id)
      else
        self.status = 422
      end
    end
  end
end

module Web::Controllers::Holidays
  class Update
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :holiday

    def call(params)
      @holiday = Holiday.find(params[:id])

      if @holiday.update_attributes(params[:holiday])
        redirect_to routes.holiday_path(@holiday.id)
      else
        self.status = 422
      end
    end
  end
end

module Web::Controllers::Holidays
  class Destroy
    include Web::Action

    def call(params)
      holiday = Holiday.find(params[:id])
      holiday.destroy
      redirect_to routes.holidays_path
    end
  end
end

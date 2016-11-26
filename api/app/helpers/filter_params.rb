module FilterParams
  def card_params
    @card_params ||= CardFilterParams.new(params).result
  end

  def holiday_params
    @holiday_params ||= HolidayFilterParams.new(params).result
  end

  def hour_params
    @hour_params ||= HourFilterParams.new(params).result
  end

  def period_params
    @period_params ||= PeriodFilterParams.new(params).result
  end

  def user_params
    @user_params ||= UserFilterParams.new(params).result
  end
end

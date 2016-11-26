class HolidayFilterParams
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def result
    valid_params.delete_if { |_, value| value.nil? }
  end

  private

  def valid_params
    {
      name:      params[:name],
      happen_at: params[:happen_at]
    }
  end
end

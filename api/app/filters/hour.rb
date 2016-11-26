class HourFilterParams
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
      name:     params[:name],
      start_at: params[:start_at],
      end_at:   params[:end_at],
      days:     params[:days]
    }
  end
end

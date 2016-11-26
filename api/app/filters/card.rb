class CardFilterParams
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
      number:  params[:number],
      user_id: params[:user_id]
    }
  end
end

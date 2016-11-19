class UserFilterParams
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def result
    valid_params.delete_if { |_, value| value.blank? }
  end

  private

  def valid_params
    {
      full_name: params[:full_name],
      phone:     params[:phone],
      address:   params[:address],
      email:     params[:email],
      password:  params[:password],
      cpf:       params[:cpf],
      role:      params[:role]
    }
  end
end

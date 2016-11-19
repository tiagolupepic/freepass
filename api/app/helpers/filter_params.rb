module FilterParams
  def user_params
    @user_params ||= UserFilterParams.new(params).result
  end
end

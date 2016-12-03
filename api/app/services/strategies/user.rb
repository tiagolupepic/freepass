require_relative 'base_user'

class UserAuthenticator < BaseUserAuthenticator
  private

  def user
    @user ||= User.find_by password: digest_password, cpf: params[:cpf]
  end

  def user_role?
    user.role == "user"
  end

  def attributes?
    params[:password].present? and params[:cpf].present?
  end
end

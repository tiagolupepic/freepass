require_relative 'base_user'

class AdminAuthenticator < BaseUserAuthenticator
  private

  def user_role?
    user.role == "admin"
  end

  def user
    @user ||= User.find_by password: digest_password, role: 'admin'
  end
end

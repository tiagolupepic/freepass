require_relative 'base_user'

class AdminAuthenticator < BaseUserAuthenticator
  private

  def user_role?
    user.role == "admin"
  end
end

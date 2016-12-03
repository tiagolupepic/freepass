require_relative 'base_user'

class UserAuthenticator < BaseUserAuthenticator
  private

  def user_role?
    user.role == "user"
  end
end

class BaseUserAuthenticator
  attr_reader :password

  def initialize(password)
    @password = password
  end

  def valid?
    return false unless password
    user.present? and valid_user? and user_role?
  end

  def object
    return unless valid?
    decorated_user
  end

  private

  def user_role?
    raise 'not implemented yet!'
  end

  def valid_user?
    user.activated?
  end

  def user
    @user ||= User.find_by password: digest_password
  end

  def decorated_user
    UserDecorator.new(user)
  end

  def digest_password
    Digest::SHA1.hexdigest(password)
  end
end

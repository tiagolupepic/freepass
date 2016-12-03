class BaseUserAuthenticator
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def valid?
    return false unless attributes?
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
    raise 'not implemented yet!'
  end

  def decorated_user
    UserDecorator.new(user)
  end

  def digest_password
    Digest::SHA1.hexdigest(params[:password])
  end

  def attributes?
    params[:password].present?
  end
end

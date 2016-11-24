class AdminAuthenticator
  # this check if exist password with user and his is admin

  attr_reader :password

  def initialize(password)
    @password = password
  end

  def valid?
    return false unless password
    user.present? and user_admin?
  end

  def object
    return unless password
    user
  end

  private

  def user_admin?
    user.role == "admin"
  end

  def user
    @user ||= User.find_by password: digest_password
  end

  def digest_password
    Digest::SHA1.hexdigest(password)
  end
end

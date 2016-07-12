module Authenticable
  def self.included(base)
    base.validates :password, presence: true, on: :create
  end

  def authenticate(attempt_password)
    return false unless attempt_password
    self.password == Digest::SHA1.hexdigest(attempt_password)
  end

  def password=(value)
    remove_password_token if reset_password_token
    self[:password] = Digest::SHA1.hexdigest(value) if value
  end

  def forget_password!
    update_attributes reset_password_token: new_token, reset_password_sent_at: Time.now
  end

  private

  def new_token
    SecureRandom.hex(13)
  end

  def remove_password_token
    update_attributes reset_password_token: nil, reset_password_sent_at: nil
  end
end

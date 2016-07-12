class User < ActiveRecord::Base
  include Authenticable
  validates :full_name, :email, presence: true
end

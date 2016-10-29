class User < ActiveRecord::Base
  include Authenticable

  has_many :cards

  validates :full_name, :email, presence: true
end

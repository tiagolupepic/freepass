class User < ActiveRecord::Base
  include Authenticable

  has_many :cards
  has_and_belongs_to_many :periods

  validates :full_name, :email, presence: true
end

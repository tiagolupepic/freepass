class User < ActiveRecord::Base
  include Authenticable

  has_many :cards
  has_and_belongs_to_many :periods
  has_and_belongs_to_many :holidays

  validates :full_name, :email, :cpf, presence: true
end

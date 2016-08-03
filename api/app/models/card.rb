class Card < ActiveRecord::Base
  belongs_to :user

  validates :user, :number, presence: true
end

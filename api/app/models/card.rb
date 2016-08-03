class Card < ActiveRecord::Base
  validates :user_id, :number, presence: true
end

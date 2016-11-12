class Holiday < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name, :happen_at, presence: true
end

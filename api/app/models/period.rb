class Period < ActiveRecord::Base
  has_and_belongs_to_many :hours
  has_and_belongs_to_many :users

  validates :name, :start_at, :end_at, presence: true
end

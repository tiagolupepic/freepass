class Hour < ActiveRecord::Base
  store_accessor :days, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday
  has_and_belongs_to_many :periods

  validates :name, :start_at, :end_at, :days, presence: true
end

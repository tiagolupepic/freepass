class Hour < ActiveRecord::Base
  store_accessor :days, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday
  validates :name, :start_at, :end_at, :days, presence: true
end

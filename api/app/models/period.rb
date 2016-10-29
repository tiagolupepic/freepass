class Period < ActiveRecord::Base
  validates :name, :start_at, :end_at, presence: true
end

class Period < ActiveRecord::Base
  has_and_belongs_to_many :hours

  validates :name, :start_at, :end_at, presence: true
end

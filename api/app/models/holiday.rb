class Holiday < ActiveRecord::Base
  validates :name, :happen_at, presence: true
end

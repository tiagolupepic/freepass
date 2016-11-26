class Holiday < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search, :against => [:name]

  has_and_belongs_to_many :users

  validates :name, :happen_at, presence: true
end

class Hour < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search,
                  :against => [:name],
                  :using => {
                    :tsearch => { prefix: true }
                  }

  store_accessor :days, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday
  has_and_belongs_to_many :periods

  validates :name, :start_at, :end_at, presence: true
end

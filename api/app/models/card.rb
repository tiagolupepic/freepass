class Card < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search,
                  :against => [:number],
                  :using => {
                    :tsearch => { prefix: true }
                  }

  belongs_to :user

  validates :user, :number, presence: true
end

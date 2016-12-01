class User < ActiveRecord::Base
  include Authenticable
  include PgSearch
  pg_search_scope :search,
                  :against => [:full_name, :email],
                  :ignoring => :accents,
                  :using => {
                    :tsearch => { prefix: true }
                  }

  has_many :cards
  has_and_belongs_to_many :periods
  has_and_belongs_to_many :holidays
  has_many :hours, through: :periods

  validates :full_name, :email, :cpf, presence: true

  default_scope {  order(updated_at: :desc) }

  state_machine initial: :requested do
    event :activate do
      transition [:requested, :deactivated] => :activated
    end

    event :deactivate do
      transition [:activated, :requested] => :deactivated
    end
  end
end

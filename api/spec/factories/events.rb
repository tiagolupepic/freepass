FactoryGirl.define do
  factory :event do
    name        'auth.card.success.true'
    user        { create :user }
    card_number '12345678'
  end
end

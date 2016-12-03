FactoryGirl.define do
  factory :event do
    name        'card.auth.success.true'
    user        { create :user }
    card_number '12345678'
  end
end

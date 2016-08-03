FactoryGirl.define do
  factory :card do
    number '123456'
    user   { create :user }
  end
end

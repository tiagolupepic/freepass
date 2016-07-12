FactoryGirl.define do
  factory :holiday do
    name     'Independency day'
    happen_at { Date.parse('2016-07-04') }
  end
end

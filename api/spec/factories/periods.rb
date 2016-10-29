FactoryGirl.define do
  factory :period do
    name     'Interval'
    start_at { Time.now.utc.to_s }
    end_at   { (Time.now.utc + 2.days).to_s }
  end
end

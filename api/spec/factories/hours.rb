FactoryGirl.define do
  factory :hour do
    name     'Interval'
    start_at { Time.now.utc.to_s }
    end_at   { Time.now.utc.to_s }
    days     { { monday: true } }
  end
end

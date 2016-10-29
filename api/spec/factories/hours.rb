FactoryGirl.define do
  factory :hour do
    name     'Interval'
    start_at { Time.now.strftime('%H:%M:%S') }
    end_at   { Time.now.strftime('%H:%M:%S') }
    days     { { monday: true } }
  end
end

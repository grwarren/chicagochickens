FactoryGirl.define do
  factory :delivery_schedule do
    date 1.week.from_now
    pickup_location 'TW'
  end
end

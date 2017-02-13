FactoryGirl.define do

  sequence(:user_id) { |n| "10#{n}".to_i }

  factory :user do
    user_id { FactoryGirl.generate(:user_id) }
    name 'Marques Marcello'
    pickup_location 'TW'
    password 'pwd'
    email 'x@y.com'

    factory :user_with_orders do
      after(:build) do |user|
        build(:order, user: user, delivery_date: 1.week.from_now)
        build(:order, user: user, delivery_date: 2.weeks.from_now)
      end
    end
  end
end

FactoryGirl.define do
  factory :user do
    sequence(:user_id) { |n| "10#{n}".to_i }
    name 'Marques Marcello'

    factory :user_with_orders do
      after(:create) do | user|
        create(:order, user: user, delivery_date: 1.week.from_now)
        create(:order, user: user, delivery_date: 2.weeks.from_now)
      end
    end
  end
end

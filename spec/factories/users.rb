FactoryGirl.define do
  factory :user do
    sequence(:user_id) { |n| "10#{n}".to_i }
    name 'Marques Marcello'

    factory :user_with_orders do
      after(:create) do | user|
        create_list(:order, 2, user: user)
      end
    end
  end
end

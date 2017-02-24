FactoryGirl.define do

  sequence(:user_id) { |n| "10#{n}".to_i }

  factory :user do
    user_id { FactoryGirl.generate(:user_id) }
    name 'Marques Marcello'
    pickup_location 'TW'
    password 'pwd'
    email { "x#{user_id}@y.com" }
  end
end

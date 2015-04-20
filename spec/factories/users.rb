FactoryGirl.define do
  factory :user do
    sequence(:user_id) { |n| "10#{n}".to_i }
    name 'Marques Marcello'
  end
end

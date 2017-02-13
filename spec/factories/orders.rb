FactoryGirl.define do
  factory :order do
    quantity 10
    delivery_date 1.week.from_now
    user_name 'Marques Marcello'
    product_name 'Chicken Eggs'
    association :user
  end
end

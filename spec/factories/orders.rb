FactoryGirl.define do
  factory :order do
    quantity 10
    delivery_date 1.week.from_now
    association :user
    association :product
  end
end

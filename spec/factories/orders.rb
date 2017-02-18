FactoryGirl.define do
  factory :order_item do
    quantity 3
    product_name 'Chicken Eggs'
  end

  factory :order do
    delivery_date 1.week.from_now
    user_name 'Marques Marcello'
    association :user

    after(:build) do | order|
      build(:order_item,  order: order)
      build(:order_item,  order: order, product_name: "Goose Egg")
    end
  end
end

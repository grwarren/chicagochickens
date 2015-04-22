FactoryGirl.define do
  factory :order do
    quantity 10
    association :user

    factory :order_with_product do
      after(:create) do |order|
        create(:product, order: order)
      end
    end
  end
end

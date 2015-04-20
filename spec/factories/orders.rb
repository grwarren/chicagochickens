FactoryGirl.define do
  factory :order do
    quantity 10

    association :user
  end
end

RSpec.configure do |config|

  config.before(:suite) do
  end

  config.before(:each) do
  end

  config.after(:each) do
    DeliverySchedule.collection.drop
    Order.collection.drop
    Product.collection.drop
    User.collection.drop
  end
end
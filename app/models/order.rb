class Order
  include MongoMapper::Document

  key :quantity, Integer
  key :delivery_date, Date
  timestamps!

  belongs_to :user
  many :products
end

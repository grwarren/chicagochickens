class Order
  include MongoMapper::Document

  key :quantity, Integer
  key :delivery_date, Date
  key :delivered, Boolean
  timestamps!

  belongs_to :user
  many :product
end

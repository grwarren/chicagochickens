class Product
  include MongoMapper::Document

  key :name, String
  key :unit, String
  timestamps!

  embedded_in :order
end

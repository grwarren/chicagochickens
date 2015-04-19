class Product
  include MongoMapper::Document

  key :name, String
  key :unit, String
  timestamps!
end

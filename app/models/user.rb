class User
  include MongoMapper::Document

  key :id, Integer
  key :name, String
  timestamps!


  many :orders
end

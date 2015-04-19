class User
  include MongoMapper::Document

  key :user_id, Integer
  key :name, String
  timestamps!


  many :orders
end

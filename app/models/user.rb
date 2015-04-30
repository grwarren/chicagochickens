class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: Integer
  field :name, type: String

  has_many :orders

  validates_presence_of :name, :user_id
  validates_uniqueness_of :user_id

  accepts_nested_attributes_for :orders

  def to_param
    user_id.to_s
  end
end

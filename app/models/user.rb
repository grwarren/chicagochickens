class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  field :user_id, type: Integer
  field :name, type: String
  field :email, type: String
  field :pickup_location, type: String

  field :password_digest, :type => String
  has_secure_password

  attr_accessor :remember_token

  validates_presence_of :user_id, :name, :email, :pickup_location
  validates_uniqueness_of :user_id, :email

  before_save { self.email = email.downcase }

  def is_admin
    user_id == 1
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def to_param
    user_id.to_s
  end

end

class User < ApplicationRecord
  has_many :drinks
  has_many :reviews
  has_many :reviewed_drinks, through: :reviews, source: :drink
  before_save { self.username = username.downcase }
  before_save { self.email = email.downcase }
  validates :username, presence: true, uniqueness: true,
                       length: {maximum: 12}
  validates :email, presence: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end

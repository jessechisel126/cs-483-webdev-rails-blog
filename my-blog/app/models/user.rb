class User < ActiveRecord::Base

  validates :username, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password

end
class User < ActiveRecord::Base

  validate :check_username_and_password
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  def check_username_and_password
    errors.add(:password, "can't be the same as username") if self.username == self.password
  end

end
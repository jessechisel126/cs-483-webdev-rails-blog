class User < ActiveRecord::Base

  validates :username, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  # Uses BCrypt to check that the password matches
  has_secure_password

end

# <rant>
#   To make inheritence work, the inheriting classes must have their model names set to the base model name.
#   As far as I can tell, this is the sort of thing that should have been included in Rails proper, as it makes
#   no sense to have inheriting classes have the inherited model name, because that fucks up routing and forms and
#   basically all helper functions, one of the reasons Rails is great.
# </rant>

class Contributor < User
  def self.model_name
    User.model_name
  end
end

class Administrator < User
  def self.model_name
    User.model_name
  end
end

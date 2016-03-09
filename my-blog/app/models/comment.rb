class Comment < ActiveRecord::Base
  validates :body, presence: true

  belongs_to :user
  belongs_to :blog_post
end

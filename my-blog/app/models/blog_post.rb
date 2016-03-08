class BlogPost < ActiveRecord::Base  
  belongs_to :user

  validates :title, presence: true, length: { maximum: 20 }
  validates :body,  presence: true
end

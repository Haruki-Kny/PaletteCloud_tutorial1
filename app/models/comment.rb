class Comment < ApplicationRecord
  belongs_to :post, class_name: 'Post', required: true 
  validates :body, presence: true
end

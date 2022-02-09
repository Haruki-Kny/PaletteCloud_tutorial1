class Comment < ApplicationRecord
  # class_name 試行錯誤中です．
  # belongs_to :original_post, class_name: 'Post', required: true 
  belongs_to :post, required: true
  validates :body, presence: true
end

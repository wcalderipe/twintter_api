class Comment < ActiveRecord::Base
  belongs_to :post

  validates :post, :text, presence: true
  validates :text, length: { maximum: 140 }
end

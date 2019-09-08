class Booklist < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 30 }
  validates :review, presence: true, length: { maximum: 300 }
  validates :image, presence: true, length: { maximum: 100 }
end

class Booklist < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 30 }
  validates :review, presence: true, length: { maximum: 600 }

  has_many :favorites, foreign_key: 'booklist_id', dependent: :destroy
  has_many :users, through: :favorites
  
  mount_uploader :image, ImageUploader
end

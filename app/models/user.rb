class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :booklists
  
  has_many :favorites
  has_many :favposts, through: :favorites, source: :booklist
  

  def like(booklist)
    favorites.find_or_create_by(booklist_id: booklist.id)
  end
  
  def unlike(booklist)
    favorite = favorites.find_by(booklist_id: booklist.id)
    favorite.destroy if favorite
  end
  
  def favpost?(booklist)
    self.favposts.include?(booklist)
  end  


end

class Item < ApplicationRecord
  has_many :category_items
  has_many :categories, through: :category_items, dependent: :destroy
  
  has_many :feedbacks, dependent: :destroy
  
  has_many :ordered_items, dependent: :destroy
  

  validates :name, presence: true
end

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :payment


  has_many :ordered_items, dependent: :destroy
end

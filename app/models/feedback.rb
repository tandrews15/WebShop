class Feedback < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :rating, presence: true, numericality:  { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :comment, presence: true


end

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :drink
  validates :content, presence: true
  validates :drink, uniqueness: { scope: :user, message: "already has your review" }
end

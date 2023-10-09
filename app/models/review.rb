class Review < ApplicationRecord
  # Associations
  belongs_to :task
  belongs_to :reviewer, class_name: 'User'

  # Validations
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, length: { maximum: 500 }

  # Scopes
  scope :five_star_reviews, -> { where(rating: 5) }
end

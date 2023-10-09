class Review < ApplicationRecord
belongs_to :task
belongs_to :reviewer, class_name: 'User'

validates :rating, presence: true, inclusion: { in: 1..5 }
validates :comment, length: { maximum: 500 }

scope :five_star_reviews, -> { where(rating: 5) }


end

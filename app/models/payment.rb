class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :task
  has_one_attached :payment_proof

  enum status: { pending: 0, approved: 1, rejected: 2 }

  # Callbacks and validations can be added here as needed
end

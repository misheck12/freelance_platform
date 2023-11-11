class Payment < ApplicationRecord
  belongs_to :client, class_name: 'User'
  belongs_to :task
  has_one_attached :payment_proof
  enum status: { pending: 0, approved: 1, rejected: -1 }
end

class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :task
  has_one_attached :payment_proof
end

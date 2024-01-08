class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :task
  has_one_attached :payment_proof
  

  enum status: { pending: 0, approved: 1, rejected: 2 }

  # Set default status before validation if it's a new record and status is not present
  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= 'pending'
  end
end

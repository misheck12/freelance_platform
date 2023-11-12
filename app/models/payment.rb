class Payment < ApplicationRecord
  belongs_to :user # change User to user
  belongs_to :task
  has_one_attached :payment_proof
  enum status: { pending: 0, approved: 1, rejected: -1 }

  attr_accessor :user # add this line to create a user= method
end

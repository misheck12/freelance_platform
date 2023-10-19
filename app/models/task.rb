class Task < ApplicationRecord
  # Validations
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :budget, presence: true, numericality: { greater_than: 0 }
  validates :deadline, presence: true

  has_one_attached :attachment
  has_many :change_requests

  # Enum for status
  enum status: { open: 0, in_progress: 1, under_review: 2, completed: 3 }

  # Callback to set default status
  before_validation :set_default_status, on: :create

  # Scopes
  scope :open_tasks, -> { where(status: :open) } # Note: Use symbol :open instead of string 'open'

  # Associations
  belongs_to :client, class_name: 'User'
  belongs_to :freelancer, class_name: 'User', optional: true
  has_one :review

  private

  def set_default_status
    self.status ||= :open
  end
end

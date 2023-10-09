class Task < ApplicationRecord
  # Validations
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :budget, presence: true, numericality: { greater_than: 0 }
  validates :deadline, presence: true

  # Enum for status
  enum status: { open: 0, in_progress: 1, under_review: 2, completed: 3 }

  # Scopes
  scope :open_tasks, -> { where(status: 'open') }

  # Associations
  belongs_to :client, class_name: 'User'
  belongs_to :freelancer, class_name: 'User', optional: true
end

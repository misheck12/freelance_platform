class Task < ApplicationRecord
  # Validations
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :budget, presence: true, numericality: { greater_than: 0 }
  validates :deadline, presence: true

  has_one_attached :completed_file
  has_one_attached :revised_file
  has_one_attached :attachment

  # Enum for status
  enum status: { open: 0, in_progress: 1, changes_requested: 2, completed: 3 }

  # Callback to set default status
  before_validation :set_default_status, on: :create

  # Scopes
  scope :open_tasks, -> { where(status: :open) } # Note: Use symbol :open instead of string 'open'

  # Associations
  belongs_to :client, class_name: 'User'
  belongs_to :freelancer, class_name: 'User', optional: true
  has_many :reviews, dependent: :destroy
  has_one :payment, dependent: :destroy

  def reviewed?
    reviews.exists?
  end

  def self.total_earning_for_freelancer (user_id)
  joins(:payment).where(freelancer_id: user_id, payments: {status: :approved})

  end

  private

  def set_default_status
    self.status ||= :open
  end
end

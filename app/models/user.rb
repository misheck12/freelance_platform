class User < ApplicationRecord
  # Existing code for Devise, enums, associations, and validations...

  # Associations
  has_many :tasks_as_client, class_name: 'Task', foreign_key: 'client_id'
  has_many :tasks_as_freelancer, class_name: 'Task', foreign_key: 'freelancer_id'
  has_many :given_reviews, class_name: 'Review', foreign_key: 'reviewer_id'
  has_one_attached :photo
  has_many :payments, dependent: :destroy
  has_many :reviews_received, through: :tasks_as_freelancer, source: :reviews

  # Method to get tasks requiring changes for freelancers
  def tasks_requiring_changes
    tasks_as_freelancer.where(status: 'changes_requested')
  end

  # Callbacks
  after_initialize :set_default_role, if: :new_record?

  validates :name, presence: true, length: { maximum: 255 } 

  private

  def set_default_role
    self.role ||= :client
  end
end

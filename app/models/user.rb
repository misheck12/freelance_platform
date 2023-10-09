class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enum for roles
  enum role: { admin: 0, client: 1, freelancer: 2 }

  # Associations
  has_many :tasks_as_client, class_name: 'Task', foreign_key: 'client_id'
  has_many :tasks_as_freelancer, class_name: 'Task', foreign_key: 'freelancer_id'
  has_many :given_reviews, class_name: 'Review', foreign_key: 'reviewer_id'

end

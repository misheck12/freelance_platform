class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

validates :title, presence: true, length: { minimum: 5, maximum: 100 }
validates :description, presence: true, length: { minimum: 10 }
validates :budget, presence: true, numericality: { greater_than: 0 }
validates :deadline, presence: true


         has_many :tasks_as_client, class_name: 'Task', foreign_key: 'client_id'
         has_many :tasks_as_freelancer, class_name: 'Task', foreign_key: 'freelancer_id'
         

         enum role: { admin: 0, client: 1, freelancer: 2 }

end

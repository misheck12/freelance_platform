class Task < ApplicationRecord
  belongs_to :client, class_name: 'User'
  belongs_to :freelancer, class_name: 'User', optional: true  

  enum status: { open: 0, in_progress: 1, under_review: 2, completed: 3 }

end

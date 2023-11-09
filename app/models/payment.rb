class Payment < ApplicationRecord
  belongs_to :client, class_name: 'User'
  belongs_to :task
end

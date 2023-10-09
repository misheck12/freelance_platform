class Review < ApplicationRecord
belongs_to :task
belongs_to :reviewer, class_name: 'User'

end

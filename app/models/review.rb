class Review < ApplicationRecord
  belongs_to :task
  belongs_to :reviewer
end

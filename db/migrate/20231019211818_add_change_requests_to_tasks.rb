class AddChangeRequestsToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :change_requests, :text
  end
end

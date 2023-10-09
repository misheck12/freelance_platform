class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.decimal :budget
      t.datetime :deadline
      t.integer :status
      t.references :client, foreign_key: { to_table: :users }
      t.references :freelancer, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end

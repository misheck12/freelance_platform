class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.references :task, null: false, foreign_key: true
      t.references :reviewer, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end

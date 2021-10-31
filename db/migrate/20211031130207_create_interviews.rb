class CreateInterviews < ActiveRecord::Migration[5.2]
  def change
    create_table :interviews do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.integer :level_id, null: false
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end

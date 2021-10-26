class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.integer :round, null: false, default: 1
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :schedules, :deleted_at
  end
end

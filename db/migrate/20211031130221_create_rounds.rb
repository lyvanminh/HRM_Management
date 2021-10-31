class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.integer :interview_id, null: false
      t.integer :duration, null: false, default: 30
      t.integer :gap, null: false, default: 5
      t.string :name, null: false
      t.string :description, null: false
      t.integer :order, null: true
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end

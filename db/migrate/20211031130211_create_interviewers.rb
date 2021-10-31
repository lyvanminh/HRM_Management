class CreateInterviewers < ActiveRecord::Migration[5.2]
  def change
    create_table :interviewers do |t|
      t.string :role, null: false
      t.integer :round_id, null: false
      t.integer :amount, null: false, default: 1
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end

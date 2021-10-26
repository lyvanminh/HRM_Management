class CreateRecruitments < ActiveRecord::Migration[5.2]
  def change
    create_table :recruitments do |t|
      t.integer :language_id, null: false
      t.integer :level_id, null: false
      t.integer :position_id, null: false
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :recruitments, :deleted_at
  end
end

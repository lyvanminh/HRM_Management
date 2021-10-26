class CreateLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :levels do |t|
      t.string :level, null: false, default: ""
      t.string :description, null: false, default: ""
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :levels, :deleted_at
  end
end

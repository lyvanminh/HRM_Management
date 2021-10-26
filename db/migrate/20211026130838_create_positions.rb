class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.string :position, null: false, default: ""
      t.string :description, null: false, default: ""
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :positions, :deleted_at
  end
end

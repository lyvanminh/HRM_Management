class CreateCriterias < ActiveRecord::Migration[5.2]
  def change
    create_table :criterias do |t|
      t.integer :type, null: false, default: 0
      t.string :content, null: false, default: ""
      t.integer :max_point, null: false, default: 5
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :criterias, :deleted_at
  end
end

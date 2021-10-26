class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :language, null: false, default: ""
      t.string :description, null: false, default: ""
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :languages, :deleted_at
  end
end

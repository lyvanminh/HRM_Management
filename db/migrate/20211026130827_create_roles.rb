class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :role, null: false, default: ""
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :roles, :deleted_at
  end
end

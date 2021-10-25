class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :phone_number, :string, limit: 11
    add_column :users, :birthday, :date
    add_column :users, :role_id, :integer
  end
end

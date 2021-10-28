class ChangeCollumnRoleIdToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :role_id, :integer, default: 0
    rename_column :users, :role_id, :role
  end
end

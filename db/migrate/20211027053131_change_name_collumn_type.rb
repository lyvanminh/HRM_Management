class ChangeNameCollumnType < ActiveRecord::Migration[5.2]
  def change
    rename_column :requests, :type, :type_request
  end
end

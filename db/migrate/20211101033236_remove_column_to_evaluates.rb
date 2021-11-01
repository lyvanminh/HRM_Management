class RemoveColumnToEvaluates < ActiveRecord::Migration[5.2]
  def change
    remove_column :evaluates, :request_id
  end
end

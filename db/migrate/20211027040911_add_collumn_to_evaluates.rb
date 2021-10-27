class AddCollumnToEvaluates < ActiveRecord::Migration[5.2]
  def change
    add_column :evaluates, :candidate_id, :integer
  end
end

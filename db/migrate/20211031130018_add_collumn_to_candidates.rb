class AddCollumnToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :interview_id, :integer, null: true
  end
end

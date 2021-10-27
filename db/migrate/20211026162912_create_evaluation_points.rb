class CreateEvaluationPoints < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluation_points do |t|
      t.integer :criteria_id, null: false
      t.integer :evaluate_id, null: false
      t.integer :point, default: 0
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :evaluation_points, :deleted_at
  end
end

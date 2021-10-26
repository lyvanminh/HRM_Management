class CreateEvaluates < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluates do |t|
      t.integer :user_id, null: false
      t.text :content, null: false
      t.integer :request_id, null: false
      t.integer :status, null: false, default: 0
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :evaluates, :deleted_at
  end
end

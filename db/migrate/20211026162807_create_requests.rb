class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :sender_id, null: false
      t.integer :status, default: 0
      t.integer :requestable_id, null: false
      t.integer :requestable_type, null: false
      t.integer :number, default: 1
      t.integer :type, default: 0
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :requests, :deleted_at
  end
end

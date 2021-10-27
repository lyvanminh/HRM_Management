class CreateParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :participants do |t|
      t.integer :participantable_id, null: false
      t.integer :participantable_type, null: false
      t.integer :schedule_id, null: false
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :participants, :deleted_at
  end
end

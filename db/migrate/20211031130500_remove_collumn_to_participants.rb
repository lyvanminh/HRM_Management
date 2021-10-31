class RemoveCollumnToParticipants < ActiveRecord::Migration[5.2]
  def change
    remove_column :participants, :participantable_id
    remove_column :participants, :participantable_type
    add_column :participants, :user_id, :integer
  end
end

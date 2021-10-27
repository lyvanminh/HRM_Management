class ChangeTypeCollumnToRequestsAndParticipants < ActiveRecord::Migration[5.2]
  def change
    change_column :requests, :requestable_type, :string
    change_column :participants, :participantable_type, :string
  end
end

class ChangeRoundToSchedules < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :round
    add_column :schedules, :round_id, :integer
  end
end

class AddCollumnToRecruitments < ActiveRecord::Migration[5.2]
  def change
    add_column :recruitments, :receive_user_id, :integer
  end
end

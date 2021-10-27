class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates do |t|
      t.string :user_name, null: false
      t.datetime :birth_day, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :address, null: false
      t.integer :chanel_id, null: false
      t.integer :level_id, null: false
      t.integer :language_id, null: false
      t.integer :position_id, null: false
      t.integer :user_refferal_id, null: false
      t.text :content_cv, null: false
      t.integer :status, default: 0
      t.string :url_cv, null: false, default: ""
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :candidates, :deleted_at
  end
end

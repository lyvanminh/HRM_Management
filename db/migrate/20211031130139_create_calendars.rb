class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.integer :participan_id
      t.string :participan_type, null: false
      t.datetime :date
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end

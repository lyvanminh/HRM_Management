class CreateChanels < ActiveRecord::Migration[5.2]
  def change
    create_table :chanels do |t|
      t.string :chanel_name, null: false, default: ""
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :chanels, :deleted_at
  end
end

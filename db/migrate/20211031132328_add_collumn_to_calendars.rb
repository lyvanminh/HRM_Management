class AddCollumnToCalendars < ActiveRecord::Migration[5.2]
  def change
    add_column :calendars, :time_array, :text
  end
end

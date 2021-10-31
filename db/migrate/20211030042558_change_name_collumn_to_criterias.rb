class ChangeNameCollumnToCriterias < ActiveRecord::Migration[5.2]
  def change
    rename_column :criterias, :type, :criteria_type
  end
end

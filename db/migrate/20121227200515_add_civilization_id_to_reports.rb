class AddCivilizationIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :civilization_id, :integer
    add_index :reports, :civilization_id
  end
end

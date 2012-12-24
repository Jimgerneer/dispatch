class AddActiveToReports < ActiveRecord::Migration
  def change
    add_column :reports, :active, :boolean, :default => true
  end
end

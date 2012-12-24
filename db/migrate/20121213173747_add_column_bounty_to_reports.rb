class AddColumnBountyToReports < ActiveRecord::Migration
  def change
    add_column :reports, :bounty, :integer, :null => false, :default => 0
  end
end

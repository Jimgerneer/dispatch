class RemoveTimeFromReports < ActiveRecord::Migration
  def up
    remove_column :reports, :time
  end

  def down
    add_column :reports, :time, :string
  end
end

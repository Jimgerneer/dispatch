class AddCoordsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :x_coord, :integer
    add_column :reports, :y_coord, :integer
  end
end

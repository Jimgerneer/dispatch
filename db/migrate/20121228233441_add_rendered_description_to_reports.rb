class AddRenderedDescriptionToReports < ActiveRecord::Migration
  def change
    add_column :reports, :rendered_description, :text
  end
end

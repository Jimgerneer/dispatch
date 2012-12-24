class AddPerpetratorIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :perpetrator_id, :integer
    add_index :reports, :perpetrator_id
  end
end

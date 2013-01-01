class RemoveColumnEvidenceFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :evidence
  end
end

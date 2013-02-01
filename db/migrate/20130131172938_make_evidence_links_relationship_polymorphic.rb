class MakeEvidenceLinksRelationshipPolymorphic < ActiveRecord::Migration

  def self.up
    rename_column :evidence_links, :report_id, :evident_id
    add_column :evidence_links, :evident_type, :string
    execute (" UPDATE evidence_links SET evident_type = 'Report' ")
  end

  def self.down
    remove_column :evidence_links, :evident_type
    rename_column :evidence_links, :evident_id, :report_id
  end

end

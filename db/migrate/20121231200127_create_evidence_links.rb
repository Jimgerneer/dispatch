class CreateEvidenceLinks < ActiveRecord::Migration
  def change
    create_table :evidence_links do |t|
      t.belongs_to :report
      t.string :link_text

      t.timestamps
    end

    add_index :evidence_links, :report_id
  end
end

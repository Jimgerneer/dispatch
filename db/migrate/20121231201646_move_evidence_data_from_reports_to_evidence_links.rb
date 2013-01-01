class MoveEvidenceDataFromReportsToEvidenceLinks < ActiveRecord::Migration
  def up
    count = 0
    Report.all.each do |report|
      report.evidence_links.create(link_text: report.evidence) if report.evidence.present?
      count += 1
    end
    p "Created #{count} evidence links"
  end

  def down
  end
end

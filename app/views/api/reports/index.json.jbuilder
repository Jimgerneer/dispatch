json.reports @reports do |json, report|
  json.(report, :id, :description, :location, :bounty, :active, :created_at, :updated_at)
  json.civilization report.civilization.name if report.civilization.present?
  json.evidence_links report.evidence_links do |evidence|
    json.url evidence.link_text
  end
  json.perpetrator do |json|
    json.(report.perpetrator, :id, :name)
  end
  json.author do |json|
    json.(report.user, :id, :minecraft_name)
  end
end

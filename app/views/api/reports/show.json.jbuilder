json.(@report, :id, :description, :location, :bounty)
json.evidence_links @report.evidence_links do |evidence|
  json.url evidence.link_text
end

json.author do |json|
  json.(@report.user, :minecraft_name)
end

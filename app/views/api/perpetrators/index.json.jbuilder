json.perpetrators @perpetrators do |json, perp|
  json.(perp, :id, :name)
end

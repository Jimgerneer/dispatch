class Perpetrator < ActiveRecord::Base
  attr_accessible :name

  has_many :reports

  scope :sort_by_highest_bounty, order("max_bounty DESC")
  scope :sort_by_most_reported, order("record_count DESC")
  scope :sort_by_most_evidence, order("evidence_count DESC")
  scope :filter_by_civ, lambda {|civ| where(["reports.civilization_id = ?", civ])}

  def self.leaderboard
    joins(:reports).
      select("perpetrators.*, MAX(bounty) as max_bounty, COUNT(reports.id) as record_count").
      group("perpetrators.id, perpetrators.name, perpetrators.created_at, perpetrators.updated_at").
      merge(Report.active)
  end

  def self.leaderboard_with_evidence
    joins("INNER JOIN reports ON reports.perpetrator_id = perpetrators.id LEFT JOIN evidence_links ON evidence_links.report_id = reports.id").
      select("perpetrators.*, MAX (bounty) as max_bounty, COUNT (reports.id) as record_count, SUM (CASE when evidence_links.id is NULL THEN 0 ELSE 1 END) AS evidence_count").
      group("perpetrators.id, perpetrators.name, perpetrators.created_at, perpetrators.updated_at").
      having("SUM (CASE when evidence_links.id is NULL THEN 0 ELSE 1 END) > 0").
      merge(Report.active)
  end

  def to_s
    name
  end
end

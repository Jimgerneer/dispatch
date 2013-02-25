class Perpetrator < ActiveRecord::Base
  attr_accessible :name

  validates_length_of :name, maximum: 16

  has_many :reports

  scope :sort_by_highest_bounty, order("max_bounty DESC")
  scope :sort_by_most_reported, order("record_count DESC")
  scope :sort_by_most_evidence, order("evidence_count DESC")
  scope :filter_by_civ, lambda {|civ| where(["reports.civilization_id = ?", civ])}
  scope :sort_by_most_wanted, order(" ((SUM(CASE when reports.active = 't' THEN reports.bounty ELSE 0 END) / (MAX(reports.bounty) + 1) )
                                    + (SUM(COALESCE(evidence_links.evidence_count,0)) - COUNT(DISTINCT reports.id) ))
                                    - ((MIN(extract(epoch FROM now() - reports.created_at)) / 86400 )
                                    + (SUM(COALESCE(evidence_links.evidence_count,0)) - COUNT(DISTINCT reports.id) ))
                                    DESC ")

  def self.leaderboard
    joins(:reports).
      select("perpetrators.*, MAX(reports.created_at) as last_reported_at, MAX(bounty) as max_bounty, COUNT(DISTINCT reports.id) as record_count").
      group("perpetrators.id, perpetrators.name, perpetrators.created_at, perpetrators.updated_at").
      merge(Report.active.unexpired)
  end

  def self.leaderboard_with_evidence
    joins("INNER JOIN reports ON reports.perpetrator_id = perpetrators.id LEFT JOIN (select evident_id, count(*) evidence_count from evidence_links group by evident_id) evidence_links ON evidence_links.evident_id = reports.id").
      select("perpetrators.*, MAX(reports.created_at) as last_reported_at, MAX(bounty) as max_bounty, COUNT(DISTINCT reports.id) as record_count, SUM(COALESCE(evidence_links.evidence_count,0)) AS evidence_count").
      group("perpetrators.id, perpetrators.name, perpetrators.created_at, perpetrators.updated_at").
      having("SUM (COALESCE(evidence_links.evidence_count,0)) > 0").
      merge(Report.active.unexpired)
  end

  def to_s
    name
  end
end

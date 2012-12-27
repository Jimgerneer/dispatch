class Perpetrator < ActiveRecord::Base
  attr_accessible :name

  has_many :reports

  def self.leaderboard
    joins(:reports).select("perpetrators.*, MAX(bounty) as max_bounty, COUNT(*) as record_count").group("perpetrators.id, perpetrators.name, perpetrators.created_at, perpetrators.updated_at").merge(Report.active)
  end

  def to_s
    name
  end
end

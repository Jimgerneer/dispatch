class Civilization < ActiveRecord::Base
  attr_accessible :name

  has_many :reports

  def self.active_list
    joins(:reports).
      select("civilizations.*, COUNT(*) as active_count").
      group("civilizations.id, civilizations.name, civilizations.created_at, civilizations.updated_at").
      merge(Report.active)
  end

  def to_s
    name
  end
end

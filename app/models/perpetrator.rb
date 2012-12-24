class Perpetrator < ActiveRecord::Base
  attr_accessible :name

  scope :active_reports, joins(:reports).merge( Report.active )

  has_many :reports

  def to_s
    name
  end
end

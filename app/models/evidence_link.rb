class EvidenceLink < ActiveRecord::Base
  attr_accessible :link_text, :report_id

  belongs_to :report

  validates_format_of :link_text, :with => URI::regexp(%w(http https)), :allow_blank => true
end

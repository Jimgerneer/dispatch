class Reward < ActiveRecord::Base
  belongs_to :claim
  belongs_to :report

  attr_accessible :claim, :report

  before_validation :generate_key

  validates_uniqueness_of :key

  def generate_key(time=Time.zone.now)
    hunter_id = claim.hunter_id
    report_author_id = report.user_id
    perpetrator_id = claim.perpetrator_id
    self.key = "#{hunter_id}-#{report_author_id}-#{perpetrator_id}-#{time.strftime("%Y%m%d")}"
  end
end

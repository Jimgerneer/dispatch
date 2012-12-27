class Report < ActiveRecord::Base
  attr_accessible :user_id, :evidence, :location, :time, :perpetrator_id, :new_perpetrator, :bounty, :active, :x_coord, :y_coord
  attr_accessor :new_perpetrator

  before_validation :create_new_perpetrator

  validates :x_coord, :y_coord, :numericality => true, :allow_blank => true
  validates :evidence, :bounty, presence: true
  validates :bounty, :numericality => true

  belongs_to :perpetrator
  belongs_to :user

  scope :active, where(active: true)
  scope :recent, order('created_at DESC')
  scope :for_perp, lambda{|perp_id| where(perpetrator_id: perp_id)}
  scope :for_author, lambda{|user_id| where(user_id: user_id)}

  def close
    self.active = false
    self.save
  end

  private

  def create_new_perpetrator
    unless perpetrator_id.present?
      return false unless new_perpetrator.present?
      self.perpetrator = Perpetrator.find_or_create_by_name(new_perpetrator)
    end
  end
end

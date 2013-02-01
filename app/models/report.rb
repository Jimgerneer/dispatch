class Report < ActiveRecord::Base
  attr_accessible :user_id, :description, :rendered_description, :location, :perpetrator_id, :civilization_id, :perpetrator_name, :civilization_name, :bounty, :active, :x_coord, :y_coord, :evidence_links_attributes
  attr_accessor :perpetrator_name, :civilization_name

  before_validation :create_new_perpetrator
  before_validation :create_new_civilization

  validates :x_coord, :y_coord, :numericality => true, :allow_blank => true
  validates :description, :bounty, presence: true
  validates :bounty, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 500 }

  markdownize! :description

  belongs_to :perpetrator
  belongs_to :civilization
  belongs_to :user
  has_many   :rewards

  has_many :evidence_links, as: :evident, dependent: :destroy
  accepts_nested_attributes_for :evidence_links, :reject_if => lambda { |a| a[:link_text].blank? }, :allow_destroy => true
  validates_associated :evidence_links
  validates_associated :perpetrator

  scope :active, where(active: true)
  scope :closed, where(active: false)
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
      return false unless perpetrator_name.present?
      self.perpetrator = Perpetrator.find_or_create_by_name(perpetrator_name)
    end
  end

  def create_new_civilization
    unless civilization_id.present?
      return nil unless civilization_name.present?
      self.civilization = Civilization.find_or_create_by_name(civilization_name)
    end
  end
end

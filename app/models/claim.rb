class Claim < ActiveRecord::Base

  attr_accessible :description, :hunter_id, :perpetrator_id, :evidence_links_attributes

  belongs_to :hunter, class_name: 'User'
  belongs_to :perpetrator

  has_many :evidence_links, as: :evident, dependent: :destroy
  accepts_nested_attributes_for :evidence_links, :reject_if => lambda { |a| a[:link_text].blank? }, :allow_destroy => true
  validates_associated :evidence_links

  validates :description, presence: true
  validates_uniqueness_of :hunter_id, scope: [:perpetrator_id]

  scope :recent, order('created_at DESC')
  scope :for_author, lambda{|user_id| where(hunter_id: user_id)}

  def to_s
    hunter.try :username
  end

end

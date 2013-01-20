class Claim < ActiveRecord::Base
  belongs_to :hunter, class_name: 'User'
  belongs_to :perpetrator

  attr_accessible :description, :hunter_id, :perpetrator_id

  validates :description, presence: true
  validates_uniqueness_of :hunter_id, scope: [:perpetrator_id]

end

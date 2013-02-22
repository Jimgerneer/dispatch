class User < ActiveRecord::Base
  attr_accessible :username

  has_many :reports
  has_many :claims
  has_many :rewards, :through => :claims

  scope :sort_by_reward_count, order("COUNT(DISTINCT rewards.id) DESC, MIN(rewards.created_at) DESC")
  scope :hunters, joins("INNER JOIN claims ON claims.hunter_id = users.id")

  def self.hunter_leaderboard
    joins("INNER JOIN claims ON claims.hunter_id = users.id INNER JOIN rewards ON rewards.claim_id = claims.id").
      select("users.*, COUNT(DISTINCT rewards.id) as reward_count").
      group("users.id, users.username, users.created_at, users.updated_at")
  end

end

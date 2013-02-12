require 'test_helper'

class RewardTest < ActiveSupport::TestCase
  test "key generation" do
    claim = Claim.new(hunter_id: 123, perpetrator_id: 5)
    report = Report.new(user_id: 1)
    reward = Reward.new(claim: claim, report: report)
    now = Time.local(2013,1,1)
    key = reward.generate_key(now)
    assert_equal "123-1-5-20130101", key
  end

  test "hunter scope" do
    user1 = User.create(username: "Decoy")
    user2 = User.create(username: "Drone")
    perp = Perpetrator.create(name: "Steve")
    report = Report.create(user_id: user2.id, perpetrator_id: perp.id)
    claim = Claim.create(hunter_id: user1.id)
    reward = Reward.create(claim: claim, report: report)
  end
end

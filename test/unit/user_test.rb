require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "hunter scope" do
    user1 = User.create(username: "Decoy")
    user2 = User.create(username: "Drone")
    perp = Perpetrator.create(name: "Steve")
    report = Report.create(user_id: user2.id, description: "YOU", perpetrator_id: perp.id)
    claim = Claim.create(hunter_id: user1.id, description: "YOU", perpetrator_id: perp.id)

    result = User.hunters.all
    assert_equal [user1], result
  end
end

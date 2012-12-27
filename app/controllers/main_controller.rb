class MainController < ApplicationController

  def index
    @perps = Perpetrator.leaderboard.all(order: "record_count DESC")
    @perps_by_bounty = Perpetrator.leaderboard.all(order: "max_bounty DESC")
  end
end

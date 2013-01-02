class MainController < ApplicationController

  def index
    @perps = Perpetrator.leaderboard.all(order: "max_bounty DESC")
    @most_wanted = @perps.first
    if params["order"] == 'highest_bounty'
      @perps = Perpetrator.leaderboard.all(order: "max_bounty DESC")
    elsif params["order"] == 'most_reports'
      @perps = Perpetrator.leaderboard.all(order: "record_count DESC")
    end
  end
end

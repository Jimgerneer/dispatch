class MainController < ApplicationController

  respond_to :html, :js

  def index
    @perps = Perpetrator.leaderboard.sort_by_highest_bounty
    @most_wanted = Perpetrator.leaderboard_with_evidence.sort_by_highest_bounty.first
    @civs = Civilization.active_list.order("name")
    if params[:order] == 'most_reports'
      @perps = Perpetrator.leaderboard.sort_by_most_reported
    elsif params[:civ].present?
      if params[:evidence] == 'true'
        @perps = Perpetrator.leaderboard_with_evidence.sort_by_most_evidence.filter_by_civ(params[:civ])
      else
        @perps = Perpetrator.leaderboard.sort_by_highest_bounty.filter_by_civ(params[:civ])
      end
    elsif params[:order] == 'most_reports_with_evidence'
      @perps = Perpetrator.leaderboard_with_evidence.sort_by_most_evidence
    elsif params[:order] == 'highest_bounty_with_evidence'
      @perps = Perpetrator.leaderboard_with_evidence.sort_by_most_evidence
    end
  end
end

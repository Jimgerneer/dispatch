class MainController < ApplicationController

  respond_to :html, :js

  def index
    @hunters = User.hunter_leaderboard.sort_by_reward_count if Reward.first.present?
    @perps = Perpetrator.leaderboard.order("last_reported_at DESC")
    @most_wanted = Perpetrator.leaderboard_with_evidence.sort_by_most_wanted.first
    @civs = Civilization.active_list.order("name")
    @search_results = Perpetrator.leaderboard.find_by_name(params[:search]) if params[:search].present?
    if params[:order] == 'most_reports'
      @perps = Perpetrator.leaderboard.sort_by_most_reported
    elsif params[:civ].present?
      if params[:evidence] == 'true'
        @perps = Perpetrator.leaderboard_with_evidence.sort_by_most_evidence.filter_by_civ(params[:civ])
      else
        @perps = Perpetrator.leaderboard.sort_by_highest_bounty.filter_by_civ(params[:civ])
      end
    elsif params[:order] == 'highest_bounty'
      @perps = Perpetrator.leaderboard.sort_by_highest_bounty
    elsif params[:order] == 'most_reports_with_evidence'
      @perps = Perpetrator.leaderboard_with_evidence.sort_by_most_reported
    elsif params[:order] == 'highest_bounty_with_evidence'
      @perps = Perpetrator.leaderboard_with_evidence.sort_by_highest_bounty
    end
  end
end

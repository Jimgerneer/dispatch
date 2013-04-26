class Api::PerpetratorsController < ApplicationController
  respond_to :json

  def index
    @perpetrators = Perpetrator.all
    render template: 'api/perpetrators/index.json.jbuilder'
  end

  def show
    @perpetrator = Perpetrator.find(params[:id])
    @active_reports = Report.unexpired.active.for_perp(params[:id])
    @expired_reports = Report.expired.active.for_perp(params[:id])
    @closed_reports = Report.expired.closed.for_perp(params[:id])
  end

  def active
    @perpetrators = Perpetrator.leaderboard
    render template: 'api/perpetrators/index.json.jbuilder'
  end
end

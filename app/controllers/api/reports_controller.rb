class Api::ReportsController < ApplicationController
  respond_to :json
  def index
    @active_reports = Report.unexpired.active
    @expired_reports = Report.expired.active
    @closed_reports = Report.expired.closed
    render template: 'api/reports/index.json.jbuilder'
  end

  def show
    @report = Report.find(params[:id])
  end

  def active
    @reports = Report.active.unexpired
    render template: 'api/reports/index.json.jbuilder'
  end
end

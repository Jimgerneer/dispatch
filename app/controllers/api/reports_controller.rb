class Api::ReportsController < ApplicationController
  respond_to :json
  def index
    @reports = Report.all
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

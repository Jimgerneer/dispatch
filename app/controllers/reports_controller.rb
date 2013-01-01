class ReportsController < ApplicationController

  before_filter :load_scope
  before_filter :logged_in?, :except => [:index]

  def index
    @reports = @scope.active.recent
    @perpetrator = Perpetrator.find params[:perpetrator_id] if params[:perpetrator_id].present?
  end

  def new
    @report = @scope.new
    3.times { @report.evidence_links.build }
  end

  def create
    @report = @scope.new(params[:report].merge(user_id: session[:user_id]))
    if @report.save
      flash[:notice] = %Q[Your report has been filed <a href="/perpetrators/#{@report.perpetrator_id}/reports">CLick Here</a> to see].html_safe
      redirect_to '/'
    else
      flash.now[:error] = @report.errors.full_messages.join(", ")
      render action: "new"
    end
  end

  def edit
    @report = Report.for_author(current_user.id).find params[:id]
    3.times { @report.evidence_links.build }
  end

  def update
    @report = Report.for_author(current_user.id).find params[:id]
      if @report.update_attributes params[:report]
        redirect_to "/user/reports"
      else
        flash.now[:error] = @report.errors.full_messages.join(", ")
        render :action => :edit
    end
  end

  def show
  end

  def destroy
    @report = Report.for_author(current_user.id).find params[:id]
    @report.close
    redirect_to "/user/reports"
  end

  def logged_in?
    if session[:user_id].present?
      true
    else
      redirect_to '/sessions/new'
    end
  end

  def load_scope
    @scope = Report
    @scope = @scope.for_perp(params[:perpetrator_id]) if params[:perpetrator_id].present?
    @scope = @scope.for_author(current_user.id) if session[:user_id].present? and request.path == "/user/reports"
  end
end

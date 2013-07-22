class ReportsController < ApplicationController

  before_filter :load_scope
  before_filter :logged_in_required, :except => [:index, :show]
  before_filter :verification_required, :except => [:index, :show]

  def index
    @reports = @scope.active.recent.unexpired
    @expired_reports = @scope.active.recent.expired
    @closed_reports = @scope.closed.recent
    @claims = Claim.for_perp(params[:perpetrator_id]).unexpired
    @expired_claims = Claim.for_perp(params[:perpetrator_id]).expired
    @perpetrator = Perpetrator.find params[:perpetrator_id] if params[:perpetrator_id].present?
    @pearl_claimed_url = ::RedditService.pearl_submit_link(@perpetrator, params[:claim]) if params[:claim].present?
    flash.now[:notice] = "Hunters have claimed they captured #{@perpetrator.name}, see below" if @claims.present? && ! flash.present?
    @reddit_url = ::RedditService.case_submit_link(@perpetrator) if params[:perpetrator_id].present?
  end


  def user
    index
    render action: 'index'
  end

  def show
    @expired_report = Report.expired.find(params[:id]) rescue nil
    @report = Report.find(params["id"])
    @perpetrator = Perpetrator.find(@report.perpetrator_id)
    @claims = Claim.for_perp(@perpetrator.id).unexpired
    flash.now[:notice] = "Hunters have claimed they captured #{@perpetrator.name}, see below" if @claims.present? && ! flash.present? && @report.active == true
    if session[:user_id].present?
      @reddit_url = ::RedditService.report_submit_link(@report, @perpetrator, current_user)
    else
      @reddit_url = ::RedditService.report_submit_link(@report, @perpetrator)
    end
  end

  def new
    @report = @scope.new
    3.times { @report.evidence_links.build }
  end

  def create
    report_params = params[:report].merge(user_id: session[:user_id])
    report_params[:description].gsub!(/</,"&lt;")
    @report = @scope.new(report_params)
    if @report.save
      flash[:notice] = %Q[Report Filed! To see all Reports <a href="/perpetrators/#{@report.perpetrator_id}/reports">Click Here</a>].html_safe
      redirect_to "/reports/#{@report.id}"
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
    report_params = params[:report]
    report_params[:description].gsub!(/</,"&lt;")
      if @report.update_attributes report_params
        redirect_to "/user/reports"
      else
        flash.now[:error] = @report.errors.full_messages.join(", ")
        render :action => :edit
    end
  end

  def activate
    @report = Report.find params[:report_id]
    @report.touch
    redirect_to "/user/reports"
  end

  def select_claim
    @report = Report.for_author(current_user.id).find params[:id]
    @perp = Perpetrator.find_by_id(@report.perpetrator_id)
    @claims = Claim.where(perpetrator_id: @perp.id).order('claims DESC').unexpired
  end

  def destroy
    @report = Report.for_author(current_user.id).find params[:id]
    @report.close and redirect_to "/user/reports" and return false if params[:reject] == "true"
    redirect_to select_claim_report_path(@report) and return false if Claim.where(perpetrator_id: @report.perpetrator_id).unexpired.any? && ! params[:claim_id].present?
    if params[:claim_id].present?
      @claim = Claim.find(params[:claim_id])
      reward = Reward.new(claim: @claim, report: @report)
      if reward.save
        flash[:notice] = "Report has been closed and point rewarded"
        @report.close
        redirect_to "/"
      else
        flash[:error] = "You can't reward that hunter at this time"
        redirect_to select_claim_report_path(@report)
      end
    else
      @report.close
      redirect_to "/user/reports"
    end
  end

  def load_scope
    @scope = Report
    @scope = @scope.for_perp(params[:perpetrator_id]) if params[:perpetrator_id].present?
    @scope = @scope.for_author(current_user.id) if session[:user_id].present? and request.path == "/user/reports"
  end
end

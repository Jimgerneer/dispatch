class ReportsController < ApplicationController

  before_filter :load_scope
  before_filter :logged_in?, :except => [:index]

  def index
    @reports = @scope.active.recent.all
    @perpetrator = Perpetrator.find params[:perpetrator_id] if params[:perpetrator_id].present?
  end

  def new
    @report = @scope.new
  end

  def create
    @report = @scope.new(params[:report].merge(user_id: session[:user_id]))
    if @report.save
      flash[:notice] = "Your report has been filed"
      redirect_to '/'
    else
      flash.now[:error] = "Your report was not created"
      render action: "new"
    end
  end

  def edit
    @report = Report.find params[:id]
  end

  def update
    @report = Report.find params[:id]
      if @report.update_attributes params[:report]
        redirect_to "/user/reports"
      else
        render :action => :edit
    end
  end

  def show
    self.destroy
  end

  def destroy
    @report = Report.find params[:id]
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
    @scope = @scope.for_author(current_user.id) if session[:user_id].present? and request == "/user/reports"
  end
end

class ClaimsController < ApplicationController

  before_filter :load_scope
  before_filter :logged_in_required

  def index
    @claims = @scope.recent
  end

  def new
    @perp = Perpetrator.find(params[:perpetrator_id])
    @claim ||= Claim.new
    3.times { @claim.evidence_links.build } unless @claim.evidence_links.any?
  end

  def create
    @claim = Claim.new(params[:claim].merge(hunter_id: session[:user_id], perpetrator_id: params[:perpetrator_id]))
    if @claim.save
      flash[:notice] = %Q[Post claims thread to Reddit with ease! Click "POST TO REDDIT" contact authors of reports. Thank you!]
      redirect_to perpetrator_reports_path(@claim.perpetrator, claim: @claim)
    else
      message = @claim.errors.reject{|k,v| k == :"evidence_links.link_text"}
      message_hash = Hash[message]
      flash[:error] = message_hash.map {|k,v| "#{k.to_s.gsub('evidence_links', 'Proof').capitalize} #{v}"}.join(", ")
      new
      render action: "new"
    end
  end

  def load_scope
    @scope = Claim
    @scope = @scope.for_author(current_user.id) if session[:user_id].present? and request.path == "/user/claims"
  end
end

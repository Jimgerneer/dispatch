class ClaimsController < ApplicationController

  def new
    @perp = Perpetrator.find(params[:perpetrator_id])
    @claim = Claim.new
  end

  def create
    @claim = Claim.new(params[:claim].merge(hunter_id: session[:user_id], perpetrator_id: params[:perpetrator_id]))
    if @claim.save
      flash[:notice] = %Q[Post claims thread to Reddit with button below and contact authors of reports. When reports close you will get points toward your bounty hunter score.]
      redirect_to "/perpetrators/#{@claim.perpetrator_id}/reports"
    else
      flash[:error] = "You have already claimed you have this person's pearl"
      redirect_to "/perpetrators/#{@claim.perpetrator_id}/reports"
    end
  end
end

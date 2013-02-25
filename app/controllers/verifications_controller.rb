class VerificationsController < ApplicationController
  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    @verifier = ::MinecraftAccountVerifier.new params[:user][:minecraft_name]
    @user.minecraft_name = params[:user][:minecraft_name]

    if @verifier.authentic? && @user.save
      session[:user_id] = @user.id
      flash[:success] = 'You are signed in and verified. IMMEDIATELY change your skin again, Thank you'
      return_to = session.delete(:return_to) || '/'
      redirect_to return_to
    else
      flash[:error] = @verifier.error
      render :edit
    end
  end
end

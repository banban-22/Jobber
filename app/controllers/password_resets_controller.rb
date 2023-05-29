class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.generate_reset_password_token!
      UserMailer.reset_password_instructions(@user).deliver_now
      flash[:notice] = "Password reset instructions have been sent to your email."
      redirect_to new_sessions_path
    else
      flash[:alert] = "Email not found"
      render :new
    end
  end

  def edit
    @user = User.find_by(reset_password_token: params[:id])
    if @user && @user.reset_password_token_expires_at && @user.reset_password_token_expires_at >= Time.zone.now
    else
      flash[:alert] = "Password reset token has expired."
      redirect_to new_password_reset_path
    end
  end

  def update
    @user = User.find_by(reset_password_token: params[:id])
    if @user && @user.reset_password_token_expires_at >= Time.zone.now
      if @user.update(user_params)
        @user.clear_reset_password_token!
        flash[:success] = "Password successfully updated."
        redirect_to new_sessions_path
      else
        render :edit
      end
    else
      flash[:alert] = "Password reset token has expired."
      redirect_to new_sessions_path
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end

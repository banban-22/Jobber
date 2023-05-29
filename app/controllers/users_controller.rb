class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        @user.is_recruiter = params[:user][:is_recruiter] == "1"
        @user.resume.attach(params[:user][:resume])
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: 'Account created!'
        else
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
        @jobs = @user.jobs.order(created_at: :desc)
    end

    def edit
        @user = current_user
    end

    def update 
        @user = User.find(params[:id])
        @user.is_recruiter = params[:user][:is_recruiter] == "1"
        @user.resume.attach(params[:user][:resume])
        if @user.save
            redirect_to root_path, notice: 'User updated successfully!'
        else
            render :edit
        end
    end

    def destroy
        @user = User.find(params[:id])
        if @user.destroy
            redirect_to root_path, notice: 'User deleted successfully!'
        else
            redirect_to root_path, alert: 'Failed to delete user!'
        end
    end 

    def  change_password
        @user = current_user
    end

    def update_password
        @user = current_user
        if @user.authenticate(params[:current_password])
            if params[:new_password] == params[:new_password_confirmation]
            @user.password = params[:new_password]
            if @user.save
                flash[:notice] = "Password Successfully Updated!"
                redirect_to root_path
            else
                flash[:alert] = "Failed to update password."
                render :change_password
            end
            else
            flash[:alert] = "Passwords Do Not Match!"
            render :change_password
            end
        else
            flash[:alert] = "Your current password is incorrect"
            render :change_password
        end
    end

    # def forgot_password
    #     @user = User.find_by(email: params[:email])
    #     if @user
    #         @user.generate_reset_password_token(expires_at: 30.minutes.from_now)
    #         @user.save
    #         UserMailer.reset_password_instructions(@user).deliver_now
    #         flash[:notice] = "Password reset instructions have been sent to your email."
    #         redirect_to reset_password_path
    #     else
    #         flash[:alert] = "Email address not found. Please try again."
    #         redirect_to forgot_password_path
    #     end
    # end

    # def reset_password
    #     @user = User.find_by(reset_password_token: params[:reset_password_token])
    #     if @user && @user.reset_password_token_valid?
    #         @user.update(password: params[:password], reset_password_token: nil, reset_password_token_expires_at: nil)
    #         flash[:notice] = "Password successfully updated."
    #         redirect_to new_session_path
    #     else
    #         flash[:alert] = "Password reset token is invalid."
    #         redirect_to root_path
    #     end
    # end

    private

    def user_params
        params.require(:user).permit(
            :first_name,
            :last_name,
            :email,
            :password,
            :password_confirmation,
            :is_recruiter,
            :resume
        )
    end
end

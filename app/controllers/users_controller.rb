class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        @user.is_recruiter = params[:user][:is_recruiter] == "1"
        @user.resume.attach(params[:user][:resume])
        @user.profile_picture.attach(params[:user][:profile_picture]) if params[:user][:profile_picture].present?

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
        @user.profile_picture.attach(params[:user][:profile_picture]) if params[:user][:profile_picture].present?

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

    private

    def user_params
        params.require(:user).permit(
            :first_name,
            :last_name,
            :email,
            :password,
            :password_confirmation,
            :is_recruiter,
            :resume,
            :profile_picture
        )
    end

end

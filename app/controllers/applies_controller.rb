class AppliesController < ApplicationController
    before_action :authenticate_user!, only: [:index, :create]
    before_action :load_job, only: [:update_status]

    def index
        @applies = current_user.applies.all.order(created_at: :desc)
    end

    def create
        @job = Job.find params[:job_id]
        @apply = @job.applies.build(user: current_user)
        @applies = Apply.new
        @applies.user = current_user
        @applies.job = Job.find params[:job_id]

        if @applies.save
            ResponsesMailer.new_apply(@applies).deliver_now if @applies.persisted?
            redirect_to root_path, notice: "Your Application submitted successfully!"
        else
            redirect_to root_path, alert: "You already applied!"
        end
    end

    def update_status
        @apply = Apply.find(params[:id])
        if current_user.is_recruiter? && @apply.update(apply_params)
            redirect_to applications_path, notice: "Status updated successfully!"
        else
            redirect_to applications_path, alert: "Failed to update status!"
        end
    end

    def send_monthly_analysis
        @users = User.all
        @users.each do |user|
            ResponsesMailer.monthly_analysis(user).deliver_now
        end
        redirect_to root_path, notice: "Monthly analysis sent successfully!"
    end
    
    private
    def load_job
        @job = Job.find params[:job_id]
    end

    def apply_params
        params.require(:apply).permit(:status)
    end
end

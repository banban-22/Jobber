class JobsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_recruiter!, only: [:new, :create, :edit, :update, :destroy]

    def index
        @jobs = Job.all.order(created_at: :desc)
        if params[:q].present?
            @q = params[:q]
            @jobs = Job.search(@q)
        else
            @q = ""
            @jobs = Job.all.order(created_at: :desc)
        end
    end

    def show
        @job = Job.find(params[:id])
        @like = current_user.likes.find_by(job_id: @job.id) if current_user
        @review = Review.new
        @reviews = @job.reviews.order(created_at: :desc)
    end

    def new
        @job = Job.new
    end

    def create
        @job = Job.new(job_params)
        @job.user = current_user
        @job.job_type = params[:job][:job_type]

        if @job.save
            redirect_to @job, notice: 'Job was successfully created.'
        else
            render :new
        end
    end

    def edit
        @job = Job.find(params[:id])
    end

    def update
        @job = Job.find(params[:id])
        @job.job_type = params[:job][:job_type]

        if @job.update job_params
            redirect_to job_path(@job), notice: "Job is successfully updated!"
        else
            render :edit
        end
    end

    def destroy
        @job = Job.find(params[:id])
        @job.destroy
        redirect_to jobs_path, alert: "Job is successfully deleted!"
    end

    def authorize!
        redirect_to root_path, alert: "Not Authorized" unless can?(:crud, @job)
    end

    def liked
        @jobs = current_user.liked_jobs.order(created_at: :desc)
    end

    def applications
        @jobs = current_user.jobs.includes(:applies)
        # @job = Job.find(params[:id])
        # @applications = Apply.where(job_id: @jobs.pluck (:id)).order(created_at: :desc)
        @applications = {}

        @jobs.each do |job|
            @applications[job.id] = job.applies.order(created_at: :desc)
        end
    end

    private
    def job_params
        params.require(:job).permit(:title, :description, :company, :location, :job_type)
    end

    def authorize_recruiter!
        unless current_user.is_recruiter? || current_user.is_admin?
        redirect_to root_path, alert: "You are not authorized to perform this action."
        end
    end
end

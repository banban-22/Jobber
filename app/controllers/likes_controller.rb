class LikesController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]

    def create
        @job = Job.find(params[:job_id])
        @like = Like.new(user: current_user, job: @job)

        if can?(:like, @job)
            if @like.save
                redirect_to job_path(@job), notice: 'Job was saved'
            else
                redirect_to job_path(@job), alert: @like.errors.full_messages.join(", ")
            end
        else
            redirect_to job_path(@job), alert: 'Cannot save your own job'
        end
    end

    def destroy
        @like = current_user.likes.find(params[:id])
        
        if can?(:destroy, @like)
            @like.destroy
            redirect_to job_path(@like.job), notice: 'Job was unsaved!'
        else
            redirect_to job_path(@like.job), alert: 'Cannot unsave job'
        end
    end
end

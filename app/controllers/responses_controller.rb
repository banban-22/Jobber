class ResponsesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def create
        review_params = params.require(:review).permit(:title, :content, :job_title, :location, :is_current, :rating)
        @job = Job.find(job_id)
        @apply = @job.applies.find_by(user_id: current_user.id)
        @save = @apply.saves.find_by(user_id: current_user.id)
        @review = Review.new
        @review.job = @review
        @review.user = current_user
        
        if @review.save
            ResponsesMailer.new_review(@review).deliver_now
            redirect_to review_path(@review), notice: 'Review created!'
        else
            render 'jobs/show'
        end
    end

    def destroy
        @job = Job.find(job_id)
        @review = Review.find(params[:id])

        if can?(:delete, @review) == false
            redirect_to root_path, alert: 'User Not Authorized!'
        else
            @review.destroy
            redirect_to job_path(@job), notice: 'Review deleted Successfully!'
        end
    end

    private
    def job_id
        params[:job_id]
    end
end

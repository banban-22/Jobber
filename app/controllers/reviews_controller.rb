class ReviewsController < ApplicationController
    before_action :find_job, only: [:new, :create, :destroy]
    before_action :authenticate_user!, only: [:create, :destroy]

def new
  @review = Review.new
end

def create
  @review = Review.new(review_params)
  p "review", @review
  @review.user = current_user
  @review.job = @job
  @reviews = @job.reviews.order(created_at: :desc)

  if @review.save
    ResponsesMailer.new_review(@review).deliver_now
    redirect_to job_path(@job), notice: 'Review created!'
  else
    flash[:alert] = 'Please fix errors below'
    render :new
  end
end

    def destroy
        @review = Review.find(params[:id])

        if can?(:delete, @review) == false
            redirect_to root_path, alert: 'User Not Authorized!'
        else
            @review.destroy
            redirect_to job_path(@job), notice: 'Review deleted Successfully!'
        end
    end

    private
    def find_job
        @job = Job.find(params[:job_id])
    end

    def review_params
        params.require(:review).permit(:title, :job_title, :location, :is_current, :rating, :content)
    end
end
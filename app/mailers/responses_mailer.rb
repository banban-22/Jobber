class ResponsesMailer < ApplicationMailer
    def new_review(review)
        @review = review
        @job = review.job
        @owner = @job.user
        mail(to: @owner.email, subject: "You got an review!")
    end

    def new_apply(applies)
        @applies = applies
        @job = applies.job
        @owner = @job.user
        mail(to: @owner.email, subject: "You got a new application!")
    end

    def monthly_analysis(user)
        @user = user
        mail(to: @user.email, subject: "Your monthly analysis")
    end
end
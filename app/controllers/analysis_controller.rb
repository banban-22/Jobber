class AnalysisController < ApplicationController
    before_action :authenticate_user!

    def index
        @user = current_user
        @applies = @user.applies.group(:status).count
        @all_statuses = ['applied', 'interview', 'shortlisted', 'reject'] 
    end

    def applications_per_month
        @user = current_user
        # @applications = current_user.applies.group_by_month(:created_at).count

    end

end

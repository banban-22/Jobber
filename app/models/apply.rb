class Apply < ApplicationRecord
    belongs_to :user
    belongs_to :job

    validates :user_id, uniqueness: {scope: :job_id, message: "has already applied"}
end

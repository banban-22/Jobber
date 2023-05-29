class Like < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validates :job_id, uniqueness: { scope: :user_id, message: "has already been saved" }
end

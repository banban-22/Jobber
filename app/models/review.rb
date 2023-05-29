class Review < ApplicationRecord
    belongs_to :job
    belongs_to :user

    validates :title, presence: true
    validates :job_title, presence: true
    validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
    validates :content, presence: true
end

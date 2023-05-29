class Job < ApplicationRecord
    has_many :reviews, dependent: :destroy
    has_many :applies, dependent: :destroy
    has_many :users
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user

    belongs_to :user, optional: true

    validates :title, presence: true
    validates :company, presence: true
    validates :location, presence: true
    validates :description, presence: true

    before_validation(:set_default_view_count)

    def self.search(keyword)
        where('title ILIKE ?', "%#{keyword}%")
    end

    private

    def set_default_view_count
        self.view_count ||= 0
    end
end

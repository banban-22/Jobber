class User < ApplicationRecord
    has_secure_password

    has_one_attached :resume
    has_one_attached :profile_picture

    has_many :jobs
    has_many :reviews
    has_many :applies, dependent: :destroy
    has_many :applications, through: :jobs, source: :applies
    has_many :likes, dependent: :destroy
    has_many :liked_jobs, through: :likes, source: :job

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: {message: "has already used", case_sensitive: false}

    def full_name
        "#{first_name} #{last_name}"
    end

    def generate_reset_password_token!
        self.reset_password_token = SecureRandom.urlsafe_base64
        self.reset_password_token_expires_at = 30.minutes.from_now
        save!
    end

    def clear_reset_password_token!
        self.reset_password_token = nil
        self.reset_password_token_expires_at = nil
        save!
    end
end

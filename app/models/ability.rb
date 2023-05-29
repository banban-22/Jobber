class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new

        if user.is_admin
            can :manage, :all
        else
            can :manage, :read
        end

        if user.is_recruiter
            can :manage, Apply, job: {user_id: user.id}
            can :create, Job, user_id:user.id
            can :edit, Job, user_id:user.id
            can :delete, Job, user_id:user.id
        else
            can :manage, :read
            can :manage, Apply, user_id: user.id
        end

        can :create, Apply do |apply|
            user.persisted? && apply.user != user.is_recruiter && apply.user_id == user.id
        end

        can :delete, Review do |review|
            review.user_id == user.id
        end

        can :like, Job do |job|
            user.persisted? && job.user != user
        end

        can :destroy, Like do |like|
            like.user == user
        end
    end
end

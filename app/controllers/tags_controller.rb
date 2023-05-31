class TagsController < ApplicationController
    def autocomplete
        tags = ActsAsTaggableOn::Tag.where("name LIKE ?", "#{params[:q]}%")
        render json: tags.pluck(:name)
    end
end

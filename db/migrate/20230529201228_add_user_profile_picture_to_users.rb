class AddUserProfilePictureToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile_picture, :oid
  end
end

class AddIsRecruiterToUser < ActiveRecord::Migration[7.0]
  def change
        add_column :users, :is_recruiter, :boolean, default: false
  end
end

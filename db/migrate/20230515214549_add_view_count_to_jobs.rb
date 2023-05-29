class AddViewCountToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :view_count, :integer, default: 0
  end
end

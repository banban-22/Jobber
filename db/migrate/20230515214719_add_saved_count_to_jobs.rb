class AddSavedCountToJobs < ActiveRecord::Migration[7.0]
  def change
        add_column :jobs, :saved_count, :integer, default: 0
  end
end

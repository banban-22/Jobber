class AddTitleIndexToJobs < ActiveRecord::Migration[7.0]
  def change
    add_index :jobs, :title
  end
end

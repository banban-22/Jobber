class AddJobTypeToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :job_type, :string
  end
end

class AddJobType2ToJobs < ActiveRecord::Migration[7.0]
  def change
        add_column :jobs, :job_type2, :string
  end
end

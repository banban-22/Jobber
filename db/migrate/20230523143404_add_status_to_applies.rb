class AddStatusToApplies < ActiveRecord::Migration[7.0]
  def change
    add_column :applies, :status, :string, default: 'Applied'
  end
end

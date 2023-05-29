class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :content
      t.string :job_title
      t.string :location
      t.boolean :is_current
      t.integer :rating
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end

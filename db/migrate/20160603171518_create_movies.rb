class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :runtime
      t.string :year
      t.text :description
      t.string :rate
      t.integer :votes_count

      t.timestamps null: false
    end
  end
end

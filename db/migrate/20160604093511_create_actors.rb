class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :name
      t.date :date_of_birth
      t.string :rate
      t.integer :votes_count

      t.timestamps null: false
    end
  end
end

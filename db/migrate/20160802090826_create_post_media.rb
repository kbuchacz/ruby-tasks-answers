class CreatePostMedia < ActiveRecord::Migration
  def change
    create_table :post_media do |t|
      t.integer :post_id

      t.integer :medium_id
      t.string :medium_type

      t.timestamps null: false
    end
  end
end
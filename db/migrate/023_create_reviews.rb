class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.string :title
      t.string :content
      t.string :likes
      t.string :dislikes
      t.references :product
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end

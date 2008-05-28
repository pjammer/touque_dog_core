class Reviewable < ActiveRecord::Migration
  def self.up
  create_table :reviewables do |t|
      t.integer :review_id
      t.integer :reviewable_id
      
      # You should make sure that the column created is
      # long enough to store the required class names.
      t.string :reviewable_type
      
      t.timestamps
    end
    
    add_index :reviewables, :review_id
    add_index :reviewables, [:reviewable_id, :reviewable_type]
  end

  def self.down
  drop_table :reviewables
  end
end

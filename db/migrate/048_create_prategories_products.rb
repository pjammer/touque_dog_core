class CreatePrategoriesProducts < ActiveRecord::Migration
  def self.up
    create_table :prategories_products, :id => false do |t|
      t.column :prategory_id, :integer, :null => false
      t.column :product_id, :integer, :null => false
    end
    add_index :prategories_products, [:product_id, :prategory_id]
    add_index :prategories_products, :prategory_id
  end

  def self.down
    remove_index :prategories_products, [:product_id, :prategory_id]
    remove_index :prategories_products, :prategory_id
    drop_table :prategories_products
  end
end

class AddCategoicalToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :categorical_id, :integer
    add_column :categories, :categorical_type, :string
  end

  def self.down
    remove_column :categories, :categorical_id
    remove_column :categories, :categorical_type
  end
end

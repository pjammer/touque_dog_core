class AddColorToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :color, :string
  end

  def self.down
    remove_column :products, :color
  end
end

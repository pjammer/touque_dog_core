class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :url
      t.string :image
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end

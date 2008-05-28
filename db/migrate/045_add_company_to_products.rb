class AddCompanyToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :company, :string
  end

  def self.down
    remove_column :products, :company
  end
end

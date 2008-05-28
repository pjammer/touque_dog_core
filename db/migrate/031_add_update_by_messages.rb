class AddUpdateByMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :updated_by, :integer
  end

  def self.down
    remove_column :messages, :updated_by
  end
end

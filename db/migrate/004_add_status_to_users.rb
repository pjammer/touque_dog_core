class AddStatusToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :status, :string, :null => :no, :default => "pending" 
  end

  def self.down
  end
end

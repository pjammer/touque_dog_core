class AddMessageCountToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :messages_count, :integer, :default => 0
  end

  def self.down
  end
end

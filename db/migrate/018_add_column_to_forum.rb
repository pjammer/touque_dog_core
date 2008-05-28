class AddColumnToForum < ActiveRecord::Migration
  def self.up
    add_column :forums, :topics_count, :integer, :default => 0
    add_column :forums, :messages_count, :integer, :default => 0
    add_column :forums, :position, :integer, :default => 0
  end

  def self.down
  end
end

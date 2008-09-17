class AddCreatedByToStickies < ActiveRecord::Migration
  def self.up
    add_column :notes, :created_by, :integer
    add_column :stickies, :created_by, :integer
  end

  def self.down
    remove_column :notes, :created_by
    remove_column :stickies, :created_by
  end
end

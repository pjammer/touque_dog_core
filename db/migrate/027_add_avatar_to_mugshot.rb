class AddAvatarToMugshot < ActiveRecord::Migration
  def self.up
    add_column :mugshots, :avatar, :boolean, :default => false
  end

  def self.down
    remove_column :mugshots, :avatar
  end
end

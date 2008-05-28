class AddUserToMugshot < ActiveRecord::Migration
  def self.up
    add_column :mugshots, :user_id, :integer
  end

  def self.down
    remove_column :mugshots, :user_id
  end
end

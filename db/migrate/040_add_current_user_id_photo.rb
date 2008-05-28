class AddCurrentUserIdPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :current_user_id, :integer
  end

  def self.down
    remove_column :photos, :current_user_id
  end
end

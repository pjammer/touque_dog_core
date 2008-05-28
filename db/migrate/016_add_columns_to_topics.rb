class AddColumnsToTopics < ActiveRecord::Migration
  def self.up
    add_column :topics, :user_id, :integer  
    add_column :topics, :title, :string   
    add_column :topics, :views, :integer, :default => 0
    add_column :topics, :messages_count, :integer, :default => 0
    add_column :topics, :last_post_id, :integer  
    add_column :topics, :last_post_at, :datetime 
    add_column :topics, :last_post_by, :integer  
    add_column :topics, :private, :boolean, :default => false
    add_column :topics, :locked, :boolean
    add_column :topics, :sticky, :boolean, :default => false
    add_column :topics, :forum_id, :integer  
  end

  def self.down
  end
end

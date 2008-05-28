class AddIndexToForums < ActiveRecord::Migration
  def self.up
    add_index "forums", ["category_id"], :name => "index_forums_on_category_id"
    add_index "forums", ["category_id"], :name => "index_forums_on_last_post_at"
  end

  def self.down
  end
end

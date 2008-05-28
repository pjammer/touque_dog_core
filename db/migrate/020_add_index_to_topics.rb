class AddIndexToTopics < ActiveRecord::Migration
  def self.up
    add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"
    add_index "topics", ["forum_id", "last_post_at"], :name => "index_topics_on_last_post_at"
  end

  def self.down
  end
end

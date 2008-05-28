class AddBlogIdToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :blog_id, :integer
  end

  def self.down
  end
end

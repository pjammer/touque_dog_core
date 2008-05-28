class AddUrlslugToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :url_slug, :string
  end

  def self.down
    remove_column :posts, :url_slug
  end
end

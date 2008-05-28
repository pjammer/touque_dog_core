class AddImageTwoAdverts < ActiveRecord::Migration
  def self.up
    add_column :adverts, :imagetwo, :string
  end

  def self.down
    remove_column :adverts, :imagetwo
  end
end

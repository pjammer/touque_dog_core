class CreateAdverts < ActiveRecord::Migration
  def self.up
    create_table :adverts do |t|
      t.string :url, :default => "http://www.touquedog.com"
      t.string :image, :default => "/images/rails.png"

      t.timestamps
    end
  end

  def self.down
    drop_table :adverts
  end
end

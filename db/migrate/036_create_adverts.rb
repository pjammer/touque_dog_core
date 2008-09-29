class CreateAdverts < ActiveRecord::Migration
  def self.up
    create_table :adverts do |t|
      t.string :url
      t.string :image 
      t.string :name 
      t.string :size
      t.datetime :start_date
      t.datetime :end_date
      t.integer :ad_count 
      t.integer :ad_count_limit
      t.string :imagetwo
      t.timestamps
    end
    Advert.new(:url => "http://www.touquedog.com",
                  :image => "/images/rails.png",
                  :name => "Example Ad",
                  :size => "BANNER")
  end

  def self.down
    drop_table :adverts
  end
end

class Glogs < ActiveRecord::Migration
  def self.up
    create_table :glogs do |t|
    t.integer :user_id
  end
  end

  def self.down
    drop_table  :glogs
  end
end

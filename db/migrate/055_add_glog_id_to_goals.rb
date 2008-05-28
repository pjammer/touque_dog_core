class AddGlogIdToGoals < ActiveRecord::Migration
  def self.up
    add_column :goals, :glog_id, :integer
  end

  def self.down
    remove_column :goals, :glog_id
  end
end

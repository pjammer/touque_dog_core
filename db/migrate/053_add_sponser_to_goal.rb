class AddSponserToGoal < ActiveRecord::Migration
  def self.up
    add_column :goals, :sponser, :string
  end

  def self.down
    remove_column :goals, :sponser
  end
end

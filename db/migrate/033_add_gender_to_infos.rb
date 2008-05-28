class AddGenderToInfos < ActiveRecord::Migration
  def self.up
    add_column :infos, :gender, :string
  end

  def self.down
    remove_column :infos, :gender
  end
end

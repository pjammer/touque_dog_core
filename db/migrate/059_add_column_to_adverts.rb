class AddColumnToAdverts < ActiveRecord::Migration
  def self.up
    add_column :adverts, :name, :string
    add_column :adverts, :size, :string
    add_column :adverts, :start_date, :datetime
    add_column :adverts, :end_date, :datetime
    add_column :adverts, :ad_count, :integer
    add_column :adverts, :ad_count_limit, :integer
  end

  def self.down
    remove_column :adverts, :name
    remove_column :adverts, :size
    remove_column :adverts, :start_date
    remove_column :adverts, :end_date
    remove_column :adverts, :ad_count
    remove_column :adverts, :ad_count_limit
  end
end

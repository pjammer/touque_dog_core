class CreateInfos < ActiveRecord::Migration
  def self.up
    create_table :infos do |t|
      t.integer :user_id, :null => false
      t.integer :age
      t.string :country
      t.string :diet_plan
      t.string :exercise_plan
      t.integer :start_weight
      t.integer :current_weight
      t.integer :feet
      t.integer :inches
      t.integer :starting_bmi
      t.integer :current_bmi
      t.date :birthdate, :default => "1919-12-25"

      t.timestamps
    end
  end

  def self.down
    drop_table :infos
  end
end

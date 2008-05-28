class CreateSpecs < ActiveRecord::Migration
  def self.up
    create_table :specs do |t|
      t.column :user_id,  :integer, :null => false
      t.integer :age
      t.string :skin_type
      t.string :makeup_exp
      t.string :country
      t.string :hair
      t.string :eye
      t.string :skin_tone
      t.timestamps
    end
  end

  def self.down
    drop_table :specs
  end
end

class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :type
      t.integer :forum_id
      t.integer :user_id
      t.integer :topic_id
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end

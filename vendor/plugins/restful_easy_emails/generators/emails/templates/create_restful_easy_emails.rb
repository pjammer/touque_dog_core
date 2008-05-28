class CreateRestfulEasyMessages < ActiveRecord::Migration
  def self.up
    create_table :emails, :force => true do |t|
      t.boolean  :receiver_deleted, :receiver_purged, :sender_deleted, :sender_purged
      t.datetime :read_at
      t.integer  :receiver_id, :sender_id
      t.string   :subject, :null => false
      t.text     :body
      t.timestamps 
    end
    
    add_index :emails, :sender_id
    add_index :emails, :receiver_id
  end

  def self.down
    drop_table :emails
  end
end

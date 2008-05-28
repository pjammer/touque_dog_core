class CreateEmails < ActiveRecord::Migration

  def self.up
    create_table :emails, :force => true do |t|
      t.column "sender_id",     :integer, :null => false
      t.column "receiver_id",   :integer, :null => false
      t.column "subject", :string, :null => false
      t.column "body", :text
      t.column "created_at",  :datetime
      t.column "read_at", :datetime
      t.column "sender_deleted", :boolean
      t.column "receiver_deleted", :boolean
      t.column "sender_purged", :boolean
      t.column "receiver_purged", :boolean
    end
    add_index(:emails, "sender_id")
    add_index(:emails, "receiver_id")
  end

  def self.down
    drop_table :emails
  end

end

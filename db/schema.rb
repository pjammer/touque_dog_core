# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 60) do

  create_table "adverts", :force => true do |t|
    t.string   "url"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagetwo"
    t.string   "name"
    t.string   "size"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "ad_count"
    t.integer  "ad_count_limit"
  end

  create_table "emails", :force => true do |t|
    t.boolean  "receiver_deleted"
    t.boolean  "receiver_purged"
    t.boolean  "sender_deleted"
    t.boolean  "sender_purged"
    t.datetime "read_at"
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.string   "subject",          :null => false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emails", ["receiver_id"], :name => "index_emails_on_receiver_id"
  add_index "emails", ["sender_id"], :name => "index_emails_on_sender_id"

  create_table "friendships", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "friend_id",   :null => false
    t.datetime "created_at"
    t.datetime "accepted_at"
  end

  create_table "infos", :force => true do |t|
    t.integer  "user_id",                                  :null => false
    t.integer  "age"
    t.string   "country"
    t.string   "diet_plan"
    t.string   "exercise_plan"
    t.integer  "start_weight"
    t.integer  "current_weight"
    t.integer  "feet"
    t.integer  "inches"
    t.integer  "starting_bmi"
    t.integer  "current_bmi"
    t.date     "birthdate",      :default => '1919-12-25'
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender"
  end

  create_table "notes", :force => true do |t|
    t.string   "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "user_id"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_user_id"
  end

  create_table "profiles", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranks", :force => true do |t|
    t.string   "title"
    t.integer  "min_posts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "status",                                  :default => "pending"
    t.string   "time_zone",                               :default => "Etc/UTC"
    t.string   "avatar"
  end

end

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

  create_table "blogs", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "categorical_id"
    t.string   "categorical_type"
  end

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "emails", :force => true do |t|
    t.integer  "sender_id",                        :null => false
    t.integer  "receiver_id",                      :null => false
    t.string   "subject",          :default => "", :null => false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "read_at"
    t.boolean  "sender_deleted"
    t.boolean  "receiver_deleted"
    t.boolean  "sender_purged"
    t.boolean  "receiver_purged"
  end

  add_index "emails", ["sender_id"], :name => "index_emails_on_sender_id"
  add_index "emails", ["receiver_id"], :name => "index_emails_on_receiver_id"

  create_table "fforum_posts", :force => true do |t|
    t.datetime "modified_at"
    t.string   "title"
    t.string   "name",        :default => "Anonymous"
    t.text     "content"
    t.integer  "parent_id",   :default => 0
  end

  create_table "forums", :force => true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topics_count",   :default => 0
    t.integer  "messages_count", :default => 0
    t.integer  "position",       :default => 0
  end

  add_index "forums", ["category_id"], :name => "index_forums_on_category_id"
  add_index "forums", ["category_id"], :name => "index_forums_on_last_post_at"

  create_table "friendships", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "friend_id",   :null => false
    t.datetime "created_at"
    t.datetime "accepted_at"
  end

  create_table "glogs", :force => true do |t|
    t.integer "user_id"
  end

  create_table "goals", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "reward"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sponser"
    t.integer  "glog_id"
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

  create_table "messages", :force => true do |t|
    t.string   "type"
    t.integer  "forum_id"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by"
  end

  create_table "mugshots", :force => true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "avatar",       :default => false
    t.integer  "user_id"
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

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "blog_id"
    t.string   "url_slug"
  end

  create_table "prategories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prategories_products", :id => false, :force => true do |t|
    t.integer "prategory_id", :null => false
    t.integer "product_id",   :null => false
  end

  add_index "prategories_products", ["product_id", "prategory_id"], :name => "index_prategories_products_on_product_id_and_prategory_id"
  add_index "prategories_products", ["prategory_id"], :name => "index_prategories_products_on_prategory_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "image"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
    t.string   "company"
  end

  create_table "profiles", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranks", :force => true do |t|
    t.string   "title"
    t.integer  "min_posts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "rating",                      :default => 0
    t.datetime "created_at",                                  :null => false
    t.string   "rateable_type", :limit => 15, :default => "", :null => false
    t.integer  "rateable_id",                 :default => 0,  :null => false
    t.integer  "user_id",                     :default => 0,  :null => false
  end

  add_index "ratings", ["user_id"], :name => "fk_ratings_user"

  create_table "replies", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviewables", :force => true do |t|
    t.integer  "review_id"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviewables", ["review_id"], :name => "index_reviewables_on_review_id"
  add_index "reviewables", ["reviewable_id", "reviewable_type"], :name => "index_reviewables_on_reviewable_id_and_reviewable_type"

  create_table "reviews", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.string   "likes"
    t.string   "dislikes"
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
  end

  create_table "specs", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "age"
    t.string   "skin_type"
    t.string   "makeup_exp"
    t.string   "country"
    t.string   "hair"
    t.string   "eye"
    t.string   "skin_tone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stickies", :force => true do |t|
    t.string   "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "topics", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "title"
    t.integer  "views",          :default => 0
    t.integer  "messages_count", :default => 0
    t.integer  "last_post_id"
    t.datetime "last_post_at"
    t.integer  "last_post_by"
    t.boolean  "private",        :default => false
    t.boolean  "locked"
    t.boolean  "sticky",         :default => false
    t.integer  "forum_id"
  end

  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"
  add_index "topics", ["forum_id", "last_post_at"], :name => "index_topics_on_last_post_at"

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
    t.integer  "messages_count",                          :default => 0
    t.string   "time_zone",                               :default => "Etc/UTC"
    t.string   "avatar"
    t.string   "password_reset_code",       :limit => 40
  end

end

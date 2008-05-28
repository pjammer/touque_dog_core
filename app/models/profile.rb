class Profile < ActiveRecord::Base
  has_one :info
  has_many :stickies
  has_many :photos
  has_one :blog
  has_many :goals
  restful_easy_emails
end

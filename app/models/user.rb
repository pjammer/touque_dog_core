require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :notes
  has_many :stickies
  has_many :goals
  has_one :glog
  has_one :info
  has_one :profile
  has_one :blog
  has_many :comments
  has_many :reviews
  has_many :messages
  has_many :topics
  has_many :photos
  has_many_friends
  restful_easy_emails  
  # Virtual attribute for the unencrypted password
  attr_accessor :password
  has_one :current_photo, :class_name => 'Photo', :foreign_key => 'current_user_id', :dependent => :nullify
  composed_of :tz, :class_name => 'TZInfo::Timezone', :mapping => %w( time_zone time_zone )
  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_format_of :login, :with => /^\w+$/i,
      :message => "can only contain letters and numbers.", :on => :create
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  validates_acceptance_of :terms_of_service, :on => :create
  before_save :encrypt_password
  before_create :make_activation_code 
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation, :avatar, :terms_of_service
  acts_as_state_machine :initial => :pending, :column => :status
    state :passive
    state :pending, :enter => :make_activation_code
    state :active, :enter => :do_activate
    state :suspended
    state :deleted, :enter => :do_delete
  event :register do
    transitions :from => :passive, :to => :pending, :guard => Proc.new {|u| !u.crypted_password.blank? }
  end
  event :activate do
    transitions :from => :pending, :to => :active
  end

    event :suspend do
      transitions :from => [:passive, :pending, :active], :to => :suspended
    end

    event :delete do
      transitions :from => [:passive, :pending, :active, :suspended], :to => :deleted
    end

    event :unsuspend do
      transitions :from => :suspended, :to => :active, :guard => Proc.new {|u| !u.activated_at.blank? }
      transitions :from => :suspended, :to => :pending, :guard => Proc.new {|u| !u.activation_code.blank? }
      transitions :from => :suspended, :to => :passive
    end

  def activated?
    # the existence of an activation code means they have not activated yet
    active?
  end

  # Returns true if the user has just been activated.
  def pending?
    @activated
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find :first, :conditions => ['login = ? and status = "active"', login]
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  # Creates, deletes or updates friendship requests.
   #  user.request_friendship_with friend
    # user.delete_friendship_with friend
    # user.accept_friendship_with friend
      def recently_activated?
         @activated
       end
       def forgot_password
           @forgotten_password = true
           self.make_password_reset_code
         end

         def reset_password
           # First update the password_reset_code before setting the
           # reset_password flag to avoid duplicate mail notifications.
           update_attributes(:password_reset_code => nil)
           @reset_password = nil
         end

         # Used in user_observer
         def recently_forgot_password?
           @forgotten_password
         end

         # Used in user_observer
         def recently_reset_password?
           @reset_password
         end

         # Used in user_observer
         def recently_activated?
           @activated
         end

    protected
      def make_password_reset_code
        self.password_reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
      end
      # before filter 
      def encrypt_password
        return if password.blank?
        self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
        self.crypted_password = encrypt(password)
      end

      def password_required?
        !password.blank?
      end

      def make_activation_code
        self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
      end
      def do_delete
        t=Time.now.to_s
        self.login += " [DELETED #{t}]"
        self.email += " [DELETED #{t}]"
      end
      # Activates the user in the database.
      def do_activate
        @activated = true
        self.activated_at ||= Time.now.utc
        self.activation_code = nil
      end

end

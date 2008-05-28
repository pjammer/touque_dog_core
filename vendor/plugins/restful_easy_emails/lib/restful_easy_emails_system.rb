# Restful_Easy_Emails
module ProtonMicro
  module RestfulEasyEmails
    module Emails

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def restful_easy_emails(options = {})
        
          has_many :emails_as_sender,    
                   :class_name => "Email", 
                   :foreign_key => "sender_id"
          
          has_many :emails_as_receiver,  
                   :class_name => "Email", 
                   :foreign_key => "receiver_id"
          
          has_many :users_who_emailed_me, 
                   :through => :emails_as_receiver, 
                   :source => :sender,
                   :select => "users.*, emails.id AS email_id, emails.subject, emails.body, emails.created_at AS sent_at, emails.read_at"

          has_many :users_whom_i_have_emailed,
                   :through => :emails_as_sender,
                   :source => :receiver,
                   :select => "users.*, emails.id AS email_id, emails.subject, emails.body, emails.created_at AS sent_at, emails.read_at"

          has_many :unread_emails,
                   :through => :emails_as_receiver,
                   :source => :sender,
                   :conditions => "emails.read_at IS NULL",
                   :select => "users.*, emails.id AS email_id, emails.subject, emails.body, emails.created_at AS sent_at, emails.read_at"
          
          has_many :read_emails,
                   :through => :emails_as_receiver,
                   :source => :sender,
                   :conditions => "emails.read_at IS NOT NULL",
                   :select => "users.*, emails.id AS email_id, emails.subject, emails.body, emails.created_at AS sent_at, emails.read_at"
                   
          has_many :inbox_emails,  
                   :class_name => "Email", 
                   :foreign_key => "receiver_id",
                   :conditions => "receiver_deleted IS NULL",
                   :order => "created_at DESC"
                   
          has_many :outbox_emails,  
                   :class_name => "Email", 
                   :foreign_key => "sender_id",
                   :conditions => "sender_deleted IS NULL",
                   :order => "created_at DESC"
                   
          has_many :trashbin_emails,  
                   :class_name => "Email", 
                   :foreign_key => "receiver_id",
                   :conditions => "receiver_deleted = true and receiver_purged IS NULL",
                   :order => "created_at DESC"

          include ProtonMicro::RestfulEasyEmails::Emails::InstanceMethods
        end
      end

      module InstanceMethods
        # Returns a list of all the users who the user has emailed
        def users_emailed
          self.users_whom_i_have_emailed
        end
  
        # Returns a list of all the users who have emailed the user
        def users_emailed_by
          self.users_who_emailed_me
        end
  
        # Returns a list of all the users who the user has mailed or been mailed by
        def all_emails
          self.users_emailed + self.users_emailed_by
        end
  
        # Alias for unread emails
        def new_emails
          self.unread_emails
        end
  
        # Alias for read emails
        def old_emails
          self.read_emails
        end
        
        # Accepts an email object and flags the email as deleted by sender
        def delete_from_sent(email)
          if email.sender_id == self.id
            email.update_attribute :sender_deleted, true
            return true
          else
            return false
          end
        end
  
        # Accepts an email object and flags the email as deleted by receiver
        def delete_from_received(email)
          if email.receiver_id == self.id
            email.update_attribute :receiver_deleted, true
            return true
          else
            return false
          end
        end
  
        # Accepts a user object as the receiver, and an email
        # and creates an email relationship joining the two users
        def send_email(receiver, email)
          Email.create!(:sender => self, :receiver => receiver, :subject => email.subject, :body => email.body)
        end        
      end   
    end
  end
end
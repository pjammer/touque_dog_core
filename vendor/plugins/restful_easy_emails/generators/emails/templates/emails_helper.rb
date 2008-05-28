## Helper for RESTful_Easy_Messages
module MessagesHelper
  
  # Generic menu
  def rezm_menu
    rezm_link_to_inbox + "|" + rezm_link_to_create_email + "|" + rezm_link_to_outbox + "|" + rezm_link_to_trash_bin
  end
  
  # Link to view the inbox
  def rezm_link_to_inbox
    link_to "Inbox", inbox_profile_emails_path
  end
  
  # Link to compose a email
  def rezm_link_to_create_email
    link_to "Write", new_profile_email_path
  end
  
  # Link to view the outbox
  def rezm_link_to_outbox
    link_to "Outbox", outbox_profile_emails_path
  end
  
  # Link to view the trash bin
  def rezm_link_to_trash_bin
    link_to "Trash", trashbin_profile_emails_path
  end
  
  # Dynamic label for the sender/receiver column in the emails.rhtml view
  def rezm_sender_or_receiver_label
    if params[:action] == "outbox"
      "Recipient"
    # Used for both inbox and trashbin
    else
      "Sender"
    end
  end
  
  # Checkbox for marking a email for deletion
  def rezm_delete_check_box(email)
    check_box_tag 'to_delete[]', email.id
  end
  
  # Link to view the email
  def rezm_link_to_email(email)
     link_to "#{h(rezm_subject_and_status(email))}", profile_email_path(rezm_user, email)
  end
  
  # Dynamic data for the sender/receiver column in the emails.rhtml view
  def rezm_sender_or_receiver(email)
    if params[:action] == "outbox"
      rezm_to_user_link(email)
    # Used for both inbox and trashbin
    else
      rezm_from_user_link(email)
    end
  end
  
  # Pretty format for email sent date/time
  def rezm_sent_at(email)
    h(email.created_at.to_date.strftime('%m/%d/%Y') + " " + email.created_at.strftime('%I:%M %p').downcase)
  end
  
  # Pretty format for email.subject which appeads the status (Deleted/Unread)
  def rezm_subject_and_status(email)
    if email.receiver_deleted?
      email.subject + " (Deleted)" 
    elsif email.read_at.nil?
      email.subject + " (Unread)"  
    else 
      email.subject
    end
  end
  
  # Link to User for Message View
  def rezm_to_user_link(email)
    link_to email.receiver_name, user_path(email.receiver_name)
  end
  
  # Link from User for Message View
  def rezm_from_user_link(email)
    link_to email.sender_name, user_path(email.sender_name)
  end
  
  # Reply Button
  def rezm_button_to_reply(email)
    button_to "Reply", reply_profile_email_path(rezm_user, email), :method => :get  
  end
  
  # Delete Button
  def rezm_button_to_delete(email)
    button_to "Delete", profile_email_path(rezm_user, email), :confirm => "Are you sure?", :method => :delete  
  end
end

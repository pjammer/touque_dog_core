class EmailsController < ApplicationController
  
  include RestfulEasyEmailsControllerSystem
  
  # Restful_authentication Filter
  before_filter :rezm_login_required
  auto_complete_for :user, :login
  # GET /emails
  def index
    redirect_to inbox_profile_emails_url
  end
  
  # GET /emails/1
  def show
    @email = Email.find_by_id(params[:id])
    
    respond_to do |format|
      if can_view(@email)
        @email.mark_email_read(rezm_user)
        format.html # show.html.erb
      else
        headers["Status"] = "Forbidden"
        format.html {render :file => "public/403.html", :status => 403}
      end
    end
  end
  
  # GET /emails/new
  def new
    @email= Email.new
  end

  # POST /emails
  def create
    @email = Email.new((params[:email] || {}).merge(:sender => rezm_user))
    
    respond_to do |format|
      if @email.save
        flash[:notice] = 'Email was sent successfully.'
        format.html { redirect_to outbox_profile_emails_path }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  # DELETE /emails/1
  def destroy
    @email= Email.find_by_id(params[:id])
    
    respond_to do |format|
      if can_view(@email)
        mark_email_for_destruction(@email)
        format.html { redirect_to current_mailbox }
      else
        headers["Status"] = "Forbidden"
        format.html {render :file => "public/403.html", :status => 403}
      end
    end
  end
  
  ### Non-CRUD Actions
  
  # GET /emails/inbox
  # GET /emails/inbox.xml
  # GET /emails/inbox.atom
  # Displays all new and read and undeleted emails in the User's inbox
  def inbox
    session[:mail_box] = "inbox"
    @emails = rezm_user.inbox_emails
    
    respond_to do |format|
      format.html { render :action => "index" }
      format.xml  { render :xml    => @emails.to_xml }
      format.atom { render :action => "index" }
    end
  end
  
  # GET /emails/outbox
  # Displays all emails sent by the user
  def outbox
    session[:mail_box] = "outbox"
    @emails = rezm_user.outbox_emails
    
    respond_to do |format|
      format.html { render :action => "index" }
    end
  end
  
  # GET /emails/trashbin
  # Displays all emails deleted from the user's inbox
  def trashbin
    session[:mail_box] = "trashbin"
    @emails = rezm_user.trashbin_emails
    
    respond_to do |format|
      format.html { render :action => "index" }
    end
  end
  
  # GET /emails/1/reply
  def reply
    @email = Email.find_by_id(params[:id])
    
    respond_to do |format|
      if can_view(@email)
        @email.recipient = @email.sender_name
        @email.subject = "Re: " + @email.subject 
        @email.body = "\n\n___________________________\n" + @email.sender_name + " wrote:\n\n" + @email.body
        format.html { render :action => "new" }
      else
        headers["Status"] = "Forbidden"
        format.html {render :file => "public/403.html", :status => 403}
      end
    end
  end
  
  # POST /emails/destroy_selected
  def destroy_selected
  
    respond_to do |format|
      if !params[:to_delete].nil?
        emails = params[:to_delete].map { |m| Email.find_by_id(m) } 
        emails.each do |email| 
          mark_email_for_destruction(email)
        end
        format.html { redirect_to current_mailbox }
      else
        format.html { redirect_to inbox_profile_emails_path }
      end
    end
  end
  
  protected
          
  # Security check to make sure the requesting user is either the 
  # sender (for outbox display) or the receiver (for inbox or trash_bin display)
  def can_view(email)
    true if !email.nil? and (rezm_user.id == email.sender_id or rezm_user.id == email.receiver_id)
  end
  
  def current_mailbox
    case session[:mail_box]
    when "inbox"
      inbox_profile_emails_path
    when "outbox"
      outbox_profile_emails_path
    when "trashbin"
      trashbin_profile_emails_path
    else
      inbox_profile_emails_path
    end
  end
  
  # Performs a "soft" delete of a email then check if it can do a destroy on the email
  # * Marks Inbox emails as "receiver deleted" essentially moving the email to the Trash Bin
  # * Marks Outbox emails as "sender_deleted" and "purged" removing the email from [:inbox_emails, :outbox_emails, :trashbin_emails]
  # * Marks Trash Bin emails as "receiver purged"
  # * Checks to see if both the sender and reciever have purged the email.  If so, the email record is destroyed
  #
  # Returns to the updated view of the current "mailbox"
  def mark_email_for_destruction(email)
    if can_view(email)
      
      # "inbox"
      if rezm_user.id == email.receiver_id and !email.receiver_deleted
        email.receiver_deleted = true             
            
      # "outbox"
      elsif rezm_user.id == email.sender_id
        email.sender_deleted = true
        email.sender_purged = true
            
      # "trash_bin"
      elsif rezm_user.id == email.receiver_id and email.receiver_deleted
        email.receiver_purged = true
      end
      
      email.save(false) 
      email.purge
    end
  end  
end

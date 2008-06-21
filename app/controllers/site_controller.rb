class SiteController < ApplicationController
  def index
    @title = $TITLE_SITE
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
      format.atom #index.atom.builder
    end
  end
  def contact 
      @contact = Contact.new 
   end 
   
   def send_contact_request   
   @contact = Contact.new(params['contact'])  
   if @contact.save     
       begin 
        Mailer::deliver_contact_message(@contact) 
        flash[:notice] = "Success!"          
        redirect_to :action =>"contact" 
       rescue  
         flash[:notice] = "Your message was not sent, try again." 
         render :action =>"contact" 
      end 
     else 
       render :action =>"contact" 
     end 
  end   
end

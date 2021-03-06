class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://www.example.com/activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://www.example.com/#{user.login}"
  end
  
  def forgot_password(user)
     setup_email(user)
     @subject    += 'You have requested to change your password'
     @body[:url]  = "http://www.example.com/reset_password/#{user.password_reset_code}"
   end

   def reset_password(user)
     setup_email(user)
     @subject    += 'Your password has been reset.'
     @body[:url] = "http://www.example.com"
   end
  
  def friend_request(mail)
    subject 'New friend request at example.com'
    from 'example <no-reply@example.com>'
    recipients mail[:friend].email
    body mail    
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "noreply@example.com"
      @subject     = ""
      @sent_on     = Time.now
      @body[:user] = user
    end
end

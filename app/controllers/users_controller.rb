class UsersController < ApplicationController

  before_filter :can_edit, :only => [:edit, :update, :destroy, :confirm_delete]
  before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  # render new.rhtml
  def new
  end

  def create
     @user = User.find_by_email_and_status(params[:user][:email], :active) if params[:user][:email]
     if @user.nil?
       @user = User.new(params[:user])
       @user.save!
     end
     @user.register! if params[:password]
     self.current_user = @user if @user.pending? # lets user be logged in before activating
     redirect_back_or_default('/')
     flash[:notice] = "Thanks for signing up!  An activation email has been sent to you.  Click the link in that email to activate your account."
   rescue ActiveRecord::RecordInvalid
     render :action => 'new'
   end

  def activate
    self.current_user = params[:activation_code].blank? ? :false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate!
      flash[:notice] = "Signup complete!"
    end
    flash[:notice] = "Signup Complete"
    @info = Info.find_by_user_id(current_user)
    redirect_back_or_default('/')
  end
  # PUT /users/1/suspend
  def suspend
    @user = User.find(params[:id])
    @user.suspend! 
    redirect_to(users_url)
  end

  # PUT /users/1/unsuspend
  def unsuspend
    @user = User.find(params[:id]) 
    @user.unsuspend! 
    redirect_to(users_url)
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.delete!
    redirect_to(users_url)
  end

  # DELETE /users/1/purge
  def purge
    @user = User.find(params[:id])
    @user.destroy
    redirect_to(users_url)
  end
   # action to perform when the user wants to change their password
    def change_password
    return unless request.post?
    if User.authenticate(current_user.login, params[:old_password])
    #      if (params[:password] == params[:password_confirmation])
    current_user.password_confirmation = params[:password_confirmation]
    current_user.password = params[:password]
    if current_user.save
     flash[:notice] = "Password updated successfully"
     redirect_to account_url
    else
     flash[:alert] = "Password not changed"
    end
    #      else
    #        flash[:alert] = "New password mismatch"
    #        @old_password = params[:old_password]
    #      end
    else
    flash[:alert] = "Old password incorrect"
    end
    end

    # action to perform when the users clicks forgot_password
    def forgot_password
    return unless request.post?
    if @user = User.find_by_email(params[:user][:email])
    @user.forgot_password
    @user.save
    redirect_back_or_default('/')
    flash[:notice] = "A password reset link has been sent to your email address: #{params[:user][:email]}"
    else
    flash[:alert] = "Could not find a user with that email address: #{params[:user][:email]}"
    end
    end

    # action to perform when the user resets the password
    def reset_password
    @user = User.find_by_password_reset_code(params[:code])
    return if @user unless params[:user]

    if ((params[:user][:password] && params[:user][:password_confirmation]))
    self.current_user = @user # for the next two lines to work
    current_user.password_confirmation = params[:user][:password_confirmation]
    current_user.password = params[:user][:password]
    @user.reset_password
    flash[:notice] = current_user.save ? "Password reset successfully" : "Unable to reset password"
    redirect_back_or_default('/')
    else
    flash[:alert] = "Password mismatch"
    end
    end


  protected
    def find_user
      @user = User.find(params[:id])
    end
end

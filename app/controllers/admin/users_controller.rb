class Admin::UsersController < ApplicationController
  before_filter :authenticate
  layout "admin"

  # renders index view of admin
  def index
    @users = User.paginate :page => params[:page], :conditions => {},:order => "id desc"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end


  # PUT /users/1/suspend
  def suspend
    @user = User.find(params[:id])
    @user.suspend! 
    redirect_to(admin_users_url)
  end

  # PUT /users/1/unsuspend
  def unsuspend
    @user = User.find(params[:id]) 
    @user.unsuspend! 
    redirect_to(admin_users_url)
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.delete!
    redirect_to(admin_users_url)
  end

  # DELETE /users/1/purge
  def purge
    @user = User.find(params[:id])
    @user.destroy
    redirect_to(admin_users_url)
  end
   
end

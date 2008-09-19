class ProfileController < ApplicationController

  def index
  end

  def show
    screen_name = params[:login]
    @user = User.find_by_login(screen_name)
    if @user
      @title = "My #{$SITE_NAME} Profile for #{screen_name}"
    else
      flash[:notice] = "No user by the name of #{screen_name} exists in the #{$SITE_NAME} community."
      redirect_to :action => "index"
    end
  end
end

class FriendshipController < ApplicationController
  before_filter :setup_friends
  
  #Send the Friend request, using hopefully has_many_friends plugin
  def create
    @user.request_friendship_with(@friend)

    flash[:notice] = "Friendship was Successfully created."
    redirect_to :controller => "profile", :action => @user.login
  end
  #Accept the request by the friend, using has_many_friends plugin
  def accept
    if @user.accept_friendship_with(@friend)
      flash[:notice] = "Friendship with #{@friend.login} accepted."
    else
      flash[:notice] = "There is no friendship with #{@friend.login}."
    end
    redirect_to :controller => "profile", :action => @user.login
  end
  #Delete or Deny the request by the friend, using has_many_friends plugin
  def decline
    if @user.delete_friendship_with(@friend)
      flash[:notice] = "Friendship with #{@friend.login} declined."
    else
      flash[:notice] = "There is no friendship with #{@friend.login}."
    end
    redirect_to :controller => "profile", :action => @user.login
  end
  
  #Cancel an existing friend, using has_many_friends plugin
  def cancel
    if @user.delete_friendship_with(@friend)
      flash[:notice] = "Friendship with #{@friend.login} cancelled."
    else
      flash[:notice] = "There is no friendship with #{@friend.login}."
    end
    redirect_to :controller => "profile", :action => @user.login
  end
  
  private
  def setup_friends
    @user = User.find(session[:user_id])
    @friend =  User.find_by_login(params[:id])
  end
end

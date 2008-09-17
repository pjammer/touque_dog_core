class StickiesController < ApplicationController
  before_filter :load_user
  # GET /stickies
  # GET /stickies.xml
  def index
    @stickies = @user.stickies.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stickies }
    end
  end

  # GET /stickies/1
  # GET /stickies/1.xml
  def show
    @stickie = @user.stickies.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stickie }
    end
  end

  def new
    @stickie = @user.stickies.build
    @user.stickie.user_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # POST /comments
  # POST /comments.xml
  def create
    @stickie = @user.stickie.new(params[:stickie])
    @stickie.user_id = current_user.id
    respond_to do |format|
      if @stickie.save
        flash[:notice] = 'You have posted successfully.'
        format.html { redirect_to(:controller => 'profile', :action => 'show', :login => @user.login) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stickies/1
  # DELETE /stickies/1.xml
  def destroy
    @stickie = @user.stickies.find(params[:id])
    @stickie.destroy

    respond_to do |format|
      format.html { redirect_to(stickies_url) }
      format.xml  { head :ok }
    end
  end
  def load_user
     screen_name = params[:login]
      @user = User.find_by_login(screen_name)
    
  end
end

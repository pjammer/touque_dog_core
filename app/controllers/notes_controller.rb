class NotesController < ApplicationController
before_filter :load_user
  # GET /notes
  # GET /notes.xml
  def index
    @notes = @user.notes.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.xml
  def show
    @note = @user.notes.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @note }
    end
  end

  def new
    @note = @user.notes.build
    @note.created_by = current_user.id
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # POST /comments
  # POST /comments.xml
  def create

    @note = @user.notes.new(params[:note])
    @note.created_by = current_user.id
    respond_to do |format|
      if @note.save
        flash[:notice] = 'You have posted successfully.'
        format.html { redirect_to(:controller => 'profile', :action => 'show', :login => @user.login) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = @user.notes.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to(notes_url) }
      format.xml  { head :ok }
    end
  end
  def load_user
    screen_name = params[:login]
    @user = User.find_by_login(screen_name)
  end
end

class Admin::PrategoriesController < ApplicationController
  before_filter :authenticate
  layout "admin"
  # GET /prategories
  # GET /prategories.xml
  def index
    @prategories = Prategory.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prategories }
    end
  end

  # GET /prategories/1
  # GET /prategories/1.xml
  def show
    @prategory = Prategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @prategory }
    end
  end

  # GET /prategories/new
  # GET /prategories/new.xml
  def new
    @prategory = Prategory.new
    @all_prategories = Prategory.find(:all, :order=>"parent_id, name")
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @prategory }
    end
  end

  # GET /prategories/1/edit
  def edit
    @prategory = Prategory.find(params[:id])
    @all_prategories = Prategory.find(:all, :order=>"parent_id, name")
  end

  # POST /prategories
  # POST /prategories.xml
  def create
    @prategory = Prategory.new(params[:prategory])

    respond_to do |format|
      if @prategory.save
        flash[:notice] = 'Prategory was successfully created.'
        format.html { redirect_to([:admin, @prategory]) }
        format.xml  { render :xml => @prategory, :status => :created, :location => @prategory }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prategory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /prategories/1
  # PUT /prategories/1.xml
  def update
    @prategory = Prategory.find(params[:id])

    respond_to do |format|
      if @prategory.update_attributes(params[:prategory])
        flash[:notice] = 'Prategory was successfully updated.'
        format.html { redirect_to([:admin, @prategory]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prategory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /prategories/1
  # DELETE /prategories/1.xml
  def destroy
    @prategory = Prategory.find(params[:id])
    @prategory.destroy

    respond_to do |format|
      format.html { redirect_to(admin_prategories_url) }
      format.xml  { head :ok }
    end
  end
end

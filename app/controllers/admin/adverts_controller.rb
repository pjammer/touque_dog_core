class Admin::AdvertsController < ApplicationController
  before_filter :authenticate
  layout "admin"
  # GET /adverts
  # GET /adverts.xml
  def index
    @adverts = Advert.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @adverts }
    end
  end

  # GET /adverts/1
  # GET /adverts/1.xml
  def show
    @advert = Advert.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @advert }
    end
  end

  # GET /adverts/new
  # GET /adverts/new.xml
  def new
    @advert = Advert.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @advert }
    end
  end

  # GET /adverts/1/edit
  def edit
    @advert = Advert.find(params[:id])
  end

  # POST /adverts
  # POST /adverts.xml
  def create
    @advert = Advert.new(params[:advert])

    respond_to do |format|
      if @advert.save
        flash[:notice] = 'Advert was successfully created.'
        format.html { redirect_to([:admin, @advert]) }
        format.xml  { render :xml => @advert, :status => :created, :location => @advert }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @advert.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /adverts/1
  # PUT /adverts/1.xml
  def update
    @advert = Advert.find(params[:id])

    respond_to do |format|
      if @advert.update_attributes(params[:advert])
        flash[:notice] = 'Advert was successfully updated.'
        format.html { redirect_to([:admin, @advert]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @advert.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /adverts/1
  # DELETE /adverts/1.xml
  def destroy
    @advert = Advert.find(params[:id])
    @advert.destroy

    respond_to do |format|
      format.html { redirect_to(admin_adverts_url) }
      format.xml  { head :ok }
    end
  end
end

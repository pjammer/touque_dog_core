class Admin::ProductsController < ApplicationController
  before_filter :authenticate
  layout "admin"
  # GET /products
  # GET /products.xml
  def index
    @products = Product.paginate :page => params[:page], :order => "id desc"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new
    @all_prategories = Prategory.find(:all, :order=>"parent_id, name")
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @all_prategories = Prategory.find(:all, :order=>"parent_id, name")
  end

  # POST /products
  # POST /products.xml
  def create
     @product = Product.new(params[:product])

     respond_to do |format|
       if @product.save
         flash[:notice] = 'Product was successfully created.'
         format.html { redirect_to([:admin, @product]) }
         format.xml  { render :xml => @product, :status => :created, :location => @product }
       else
         format.html { render :action => "new" }
         format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
       end
     end
   end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Product was successfully updated.'
        format.html { redirect_to(admin_product_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(admin_products_url) }
      format.xml  { head :ok }
    end
  end
end

class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :check_stock_inventory

  # GET /products or /products.json
  def index
    @products = Product.all.reverse
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    
    respond_to do |format|
      if @product.save
        format.turbo_stream
        format.html { redirect_to root_path, notice: "Product was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@product, partial: 'products/form', locals: { product: @product }) }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.turbo_stream
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
       
      else
        format.html { render :edit, status: :unprocessable_entity }

        format.turbo_stream { render turbo_stream: turbo_stream.replace(@product, partial: 'products/form', locals: { product: @product }) }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to products_path, notice: 'Product was successfully destroyed.'}
    end
  end

  def management
    @products_below_limit = CheckIfProductIsBelowLimitJob.new.display_products
  end

  def check_stock_inventory
    CheckIfProductIsBelowLimitJob.perform_now
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :quantity, :price, :image)
  end
end

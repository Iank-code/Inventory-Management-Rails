# class ProductsController < ApplicationController
#   before_action :set_product, only: %i[ show edit update destroy ]
#   before_action :checkIfIsBelowLimit

#   # GET /products or /products.json
#   def index
#     @products = Product.all
#     @products
#   end

#   # Mocking User Purchase to decrease quantity of product
#   def user_purchase(productId, quantity)
#     @product = Product.find(params[:id])
#     @product.quantity -= quantity

#     @product.save

#   end


#   # GET /products/1 or /products/1.json
#   def show
#     @product = Product.find(params[:id])
#     @product
#   end

#   # GET /products/new
#   def new
#     @product = Product.new
#   end

#   # GET /products/1/edit
#   def edit
#   end

#   # POST /products or /products.json
#   def create
#     @product = Product.new(product_params)

#     respond_to do |format|
#       if @product.save
#         format.html { redirect_to @product, notice: "Product was successfully created." }
#         format.turbo_stream
#         # format.json { render :show, status: :created, location: @product }
#       else
#         format.html { render :new, status: :unprocessable_entity }
        
#         format.turbo_stream { render turbo_stream: turbo_stream.replace(@product, partial: 'products/form', locals: { product: @product }) }
#       end
#     end
#   end

#   # PATCH/PUT /products/1 or /products/1.json
#   def update
#     respond_to do |format|
#       if @product.update(product_params)
#         format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }

#         format.turbo_stream
#       else
#         format.html { render :edit, status: :unprocessable_entity }

#         format.turbo_stream { render turbo_stream: turbo_stream.replace(@product, partial: 'products/form', locals: { product: @product }) }
#       end
#     end
#   end

#   # DELETE /products/1 or /products/1.json
#   def destroy
#     @product.destroy!

#     respond_to do |format|
#       format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
#       format.turbo_stream
#     end
#   end

#   # Products here have quantity less or equal to 10
#   def management; end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_product
#       @product = Product.find(params[:id])
#     end

#     # Only allow a list of trusted parameters through.
#     def product_params
#       params.require(:product).permit(:name, :description, :quantity, :price, :image)
#     end
# end


class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :checkIfIsBelowLimit

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # Mocking User Purchase to decrease quantity of product
  def user_purchase
    @product = Product.find(params[:id])
    @product.quantity -= params[:quantity].to_i
    @product.save
    redirect_to products_path, notice: "Purchase successful!"
  end

  # GET /products/1 or /products/1.json
  def show; end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit; end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.turbo_stream
        # format.turbo_frame { render partial: 'products/product', locals: { product: @product } }
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
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.turbo_stream
       
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
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@product) }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :quantity, :price, :image)
  end
end

class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    # access right
    begin
      if User.isCustomer
        redirect_to(root_path, notice: 'No access right - Manager only!') 
        return
      end
      rescue NullPointerException
        redirect_to "/users/sign_in", notice: 'Please sign in!'
        return
    end 

    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    begin
      if User.isCustomer
        redirect_to(root_path, notice: 'No access right') 
        return
      end
      rescue ArgumentError
        redirect_to(root_path, notice: 'No user logged in')
        return
    end 
  end

  # POST /products or /products.json
  def create
      @product = Product.new(product_params)
  
      respond_to do |format|
        if @product.save
          format.html { redirect_to @product, notice: "Product was successfully created." }
          format.json { render :show, status: :created, location: @product }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    begin
      if User.isCustomer
        redirect_to(root_path, notice: 'No access right') 
        return
      end
      rescue ArgumentError
        redirect_to(root_path, notice: 'No user logged in')
        return
    end 

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    #check access right
    self.check_access_right

    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:product_id, :name, :description, :unit_price)
    end
  
end

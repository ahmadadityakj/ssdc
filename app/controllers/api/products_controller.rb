class Api::ProductsController < ApiController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  def index
    @products = Product.search params
    render json: {:status => "success", :code => 200, :message => "", :data => @products}
  end

  # GET /products/1
  # GET /products/1.json
  def show
    render json: {:status => "success", :code => 200, :message => "", :data => @product}
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    render json: {:status => "success", :code => 200, :message => "", :data => @product}
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    if @product.update(product_params)
      render json: {:status => "success", :code => 200, :message => "Product was successfully updated.", :data => @product}
    else
      render json: {:status => "error", :code => 204, :message => "Product unsuccessfully update."}
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    render json: {:status => "success", :code => 200, :message => "Product was successfully destroyed."}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :type, :length, :width, :height, :weight)
    end
end

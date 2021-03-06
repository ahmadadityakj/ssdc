class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    #@products = Product.all
    @results = ''
    if params[:results].present?
      @results = params[:results]
    end
    @length = ''
    if params[:length].present?
      @length = params[:length]
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
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

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def select_products_by_specs
    # procedure_modifiers = args[:procedure_modifiers].map { |m| Vo::ProcedureModifiersVO.new(m[:code], m[:modifiers]) }
    # procedure_modifiers_calculator = ProcedureModifiersCalculator.new(procedure_modifiers, args[:business_entity_id], args[:patient_id])
    # results = procedure_modifiers_calculator.calculate_modifiers
    # if results[0].present?
    #   results[0].modifiers.compact!
    # end
    @results = Product.where('length <= ?', params[:length])
    respond_to do |format|
      format.html { redirect_to products_url(params: {results: @results, length: params[:length]}), notice: 'Selected Products', results: @results, length: params[:length] }
      #format.json { head :no_content }
    end
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

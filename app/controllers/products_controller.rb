class ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  def index
    @products = Product.all
    @products = @products.active if params[:status] == "active"
    @products = @products.inactive if params[:status] == "inactive"
    @products = @products.low_stock if params[:stock] == "low"
    @products = @products.out_of_stock if params[:stock] == "out"
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: "Product was successfully deleted.", status: :see_other
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :sku, :price, :stock_quantity, :status)
  end
end

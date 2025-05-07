class OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_order, only: [ :show, :update, :destroy, :process_order, :ship_order, :deliver_order, :cancel_order ]

  def index
    @orders = Order.all.order(created_at: :desc)
    @orders = @orders.where(status: params[:status]) if params[:status].present?
  end

  def show
  end

  def new
    @order = Order.new
    @customers = Customer.all.order(:name)
    @products = Product.active.where("stock_quantity > 0").order(:name)
  end

  def create
    @order = Order.new(order_params)

    if params[:order_items]
      params[:order_items].each do |item|
        product_id = item[:product_id]
        quantity = item[:quantity].to_i

        if product_id.present? && quantity > 0
          product = Product.find(product_id)
          if product && quantity <= product.stock_quantity
            @order.order_items.build(
              product_id: product_id,
              quantity: quantity,
              unit_price: product.price
            )
          end
        end
      end
    end

    if @order.save
      redirect_to @order, notice: "Order was successfully created."
    else
      @customers = Customer.all.order(:name)
      @products = Product.active.where("stock_quantity > 0").order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: "Order was successfully updated."
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    if @order.status == "pending" || @order.status == "canceled"
      @order.destroy
      redirect_to orders_url, notice: "Order was successfully deleted.", status: :see_other
    else
      redirect_to @order, alert: "Cannot delete orders that are being processed or completed.", status: :unprocessable_entity
    end
  end

  def process_order
    if @order.process
      redirect_to @order, notice: "Order is now being processed."
    else
      redirect_to @order, alert: "Could not process order."
    end
  end

  def ship_order
    if @order.ship
      redirect_to @order, notice: "Order has been shipped."
    else
      redirect_to @order, alert: "Could not ship order."
    end
  end

  def deliver_order
    if @order.deliver
      redirect_to @order, notice: "Order has been delivered."
    else
      redirect_to @order, alert: "Could not mark order as delivered."
    end
  end

  def cancel_order
    if @order.cancel
      redirect_to @order, notice: "Order has been canceled and inventory returned."
    else
      redirect_to @order, alert: "Could not cancel order."
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:customer_id, :status)
  end
end

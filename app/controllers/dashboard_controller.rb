class DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
    @total_orders_this_month = Order.this_month.count
    @total_revenue_this_month = Order.this_month.where(status: [ "processing", "shipped", "delivered" ]).sum(:total)

    @top_products = Product.joins(:order_items)
                           .select("products.*, SUM(order_items.quantity) as total_sold")
                           .group("products.id")
                           .order("total_sold DESC")
                           .limit(5)

    @low_stock_products = Product.low_stock.active

    @daily_revenue = Order.this_month.where(status: [ "processing", "shipped", "delivered" ])
                          .group_by_day(:created_at)
                          .sum(:total)

    @recent_orders = Order.order(created_at: :desc).limit(5)
  end
end

class CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [ :show, :edit, :update, :destroy ]

  def index
    @customers = Customer.all.order(name: :asc)
  end

  def show
    @orders = @customer.orders.order(created_at: :desc)
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to @customer, notice: "Customer was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: "Customer was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @customer.orders.any?
      redirect_to @customer, alert: "Cannot delete customer with existing orders.", status: :unprocessable_entity
    else
      @customer.destroy
      redirect_to customers_url, notice: "Customer was successfully deleted.", status: :see_other
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :phone, :address)
  end
end

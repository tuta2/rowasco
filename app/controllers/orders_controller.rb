class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authorized!
  load_and_authorize_resource 

  def index
    @orders = Order.all
  end

  def show; end

  def new
    @Order = Order.new
  end

  def edit; end

  def create
    @Order = Order.new(order_params)


    respond_to do |format|
      if @order.save
        format.html { 
          redirect_to '/orders', notice: "Order Booked" 
        }
      else
        format.html {render 'orders/new', status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to "/orders", notice: "Order Updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to "/orders", notice: "Order Removed" }
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:order_uniq_id, :total_amount, :mode_of_payment, :phone_number, :account_number, :full_name, :user_id)
  end
end

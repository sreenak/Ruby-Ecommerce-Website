class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @orders = current_user.orders.valid_orders
  end

  def show
    @order = current_user.orders.valid_orders.find params[:id]
  end
end

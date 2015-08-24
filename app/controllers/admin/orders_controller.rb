class Admin::OrdersController < AdminController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  add_crumb('Orders') { |instance| instance.send :admin_orders_path }

  # GET /admin/orders
  def index
    @order_search = Order.ransack(search_params)
    @orders = @order_search.result(distinct: true).valid_orders.order(created_at: :desc).page params[:page]

  end

  # GET /admin/orders/1
  def show
  end

  # GET /admin/orders/1/edit
  def edit
  end

  # PATCH/PUT /admin/orders/1
  def update
    if @order.update(order_params)
      redirect_to admin_orders_path, notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/orders/1
  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'Order was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

  def search_params
    if params[:created_at].present?
      params[:q] = {} unless params[:q].present?
      params[:q][:created_at_gt], params[:q][:created_at_lt] = params[:created_at]
    end
    params[:q]
  end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params[:order].permit(:status)
    end
end

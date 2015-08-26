class Admin::OrderStatusesController < AdminController
  add_crumb('Order') { |instance| instance.send :admin_orders_path }
  add_crumb('Status') { |instance| instance.send :admin_order_order_statuses_path }
  before_action :set_order
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  # GET /admin/shipments
  def index
    @statuses = @order.order_statuses
  end

  # GET /admin/shipments/1
  def show
  end

  # GET /admin/shipments/new
  def new
    @status = OrderStatus.new
  end

  # GET /admin/shipments/1/edit
  def edit
  end

  # POST /admin/shipments
  def create
    @status = @order.order_statuses.new(status_params)
    @status.save
    redirect_to admin_order_order_statuses_path(@order), notice: 'Order Status was successfully created.'
  end

  # PATCH/PUT /admin/shipments/1
  def update
    if @status.update(status_params)
      redirect_to admin_order_order_statuses_path(@order), notice: 'Order Status was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/shipments/1
  def destroy
    @status.destroy
    redirect_to admin_order_order_statuses_path(@order), notice: 'Order Status was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_status
    @status = @order.order_statuses.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def status_params
    params[:order_status].permit :status_type ,:date
  end
end
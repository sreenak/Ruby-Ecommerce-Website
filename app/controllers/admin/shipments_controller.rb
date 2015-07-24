class Admin::ShipmentsController < AdminController
  before_action :set_order
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]

  # GET /admin/shipments
  def index
    @shipments = Shipment.all
  end

  # GET /admin/shipments/1
  def show
  end

  # GET /admin/shipments/new
  def new
    @shipment = Shipment.new
  end

  # GET /admin/shipments/1/edit
  def edit
  end

  # POST /admin/shipments
  def create
    @shipment = @order.shipments.new(shipment_params)
    @shipment.save
    redirect_to admin_order_shipments_path(@order), notice: 'Shippings was successfully created.'
  end

  # PATCH/PUT /admin/shipments/1
  def update
    if @shipment.update(shipment_params)
      redirect_to admin_order_shipments_path(@order), notice: 'Shippings was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/shipments/1
  def destroy
    @shipment.destroy
    redirect_to admin_order_shipments_path(@order), notice: 'Shippings was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_shipment
    @shipment = @order.shipments.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def shipment_params
    params[:shipment].permit :status ,:tracking_url
  end
end
class Admin::ShippingsController < AdminController
  before_action :set_order
  before_action :set_shipping, only: [:show, :edit, :update, :destroy]

  # GET /admin/shippings
  def index
    @shippings = Shipping.all
  end

  # GET /admin/shippings/1
  def show
  end

  # GET /admin/shippings/new
  def new
    @shipping = Shipping.new
  end

  # GET /admin/shippings/1/edit
  def edit
  end

  # POST /admin/shippings
  def create
    @shipping = @order.shippings.new(shipping_params)
    @shipping.save
    redirect_to admin_order_shippings_path(@order), notice: 'Shippings was successfully created.'
  end

  # PATCH/PUT /admin/shippings/1
  def update
    if @shipping.update(shipping_params)
      redirect_to admin_order_shippings_path(@order), notice: 'Shippings was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/shippings/1
  def destroy
    @shipping.destroy
    redirect_to admin_order_shippings_path(@order), notice: 'Shippings was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_shipping
    @shipping = @order.shippings.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def shipping_params
    params[:shipping].permit :status ,:tracking_id
  end
end
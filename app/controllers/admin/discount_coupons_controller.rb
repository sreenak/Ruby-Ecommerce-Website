class Admin::DiscountCouponsController < AdminController
  add_crumb('Discount coupons') { |instance| instance.send :admin_discount_coupons_path }
  before_action :set_discount_coupon, only: [:show, :edit, :update, :destroy]

  # GET /admin/discount_coupons
  def index
    @discount_coupons = DiscountCoupon.page params[:page]
  end

  # GET /admin/discount_coupons/1
  def show
  end

  # GET /admin/discount_coupons/new
  def new
    @discount_coupon = DiscountCoupon.new
  end

  # GET /admin/discount_coupons/1/edit
  def edit
  end

  # POST /admin/discount_coupons
  def create
    @discount_coupon = DiscountCoupon.new(discount_coupon_params)

    if @discount_coupon.save
      redirect_to admin_discount_coupons_path, notice: 'Discount coupon was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/discount_coupons/1
  def update
    if @discount_coupon.update(discount_coupon_params)
      redirect_to admin_discount_coupons_path, notice: 'Discount coupon was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/discount_coupons/1
  def destroy
    @discount_coupon.destroy
    redirect_to admin_discount_coupons_path, notice: 'Discount coupon was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_discount_coupon
    @discount_coupon = DiscountCoupon.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def discount_coupon_params
    params[:discount_coupon].permit(:code, :amount, :applies_as, :maximum_usages, :minimum_order_price)
  end
end

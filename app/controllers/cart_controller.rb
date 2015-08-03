class CartController < ApplicationController
  def show
  end

  def add_dress
    dress = Dress.find params[:id]
    line_item = @cart.add_item dress, params[:total_price], dress.name
    respond_to do |format|
      if line_item
        # line_item.create_customised_dress_order_item details: params[:details]
        line_item.create_dress_line_item_option params.permit(:standard_size_id,:angle_0,:angle_90,:angle_180,:angle_360, :details)
        session[:order_id] = @cart.id # Save order id to session since it's saved now
        format.html { redirect_to :cart, notice: 'Dress added to cart.' }
        format.json { head :no_content }
      else
        format.html { redirect_to :back, alert: 'Something happened!' }
        format.json { render json: {error: 'Something happened!'} }
      end
    end
  end

  def add_product
    quantity = params[:quantity] ? params[:quantity] : 1
    product = Product.find params[:product_id]
    line_item = @cart.add_item product, product.price.to_f, product.name, quantity
    respond_to do |format|
      if line_item
        line_item.create_product_line_item_option params.permit(:standard_size_id, :is_gift, :message)
        session[:order_id] = @cart.id # Save order id to session since it's saved now
        format.html { redirect_to :cart, notice: 'Product added to cart.' }
        format.json { head :no_content }
      else
        format.html { redirect_to :back, alert: 'Something happened!' }
        format.json { render json: {error: 'Something happened!'} }
      end
    end
  end

  def apply_discount
    if DiscountCoupon.find_by_code params[:coupon_code]
      response = @cart.apply_discount params[:coupon_code]
      redirect_to :back, notice: response
    else
      response = @cart.apply_gift_card params[:coupon_code]
      if response
        redirect_to :back, notice: 'Discount applied.'
      else
        redirect_to :back, alert: 'Invalid discount code!'
      end
    end
  end

  def update
    @cart.update_quantity params[:quantities]
    redirect_to :back, notice: 'Cart updated.'
  end

  def delete
    @cart.remove_item params[:id]
    redirect_to :back, notice: 'Removed Item successfully'
  end
end

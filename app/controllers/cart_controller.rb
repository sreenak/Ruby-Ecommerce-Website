class CartController < ApplicationController
  def show
  end

  def add_dress
    line_item = @cart.add_dress params[:id], params[:total_price]
    respond_to do |format|
      if line_item
        # line_item.create_customised_dress_order_item details: params[:details]
        session[:order_id] = @cart.id # Save order id to session since it's saved now - check Order.add_dress
      else
        format.html { redirect_to :back, alert: 'Something happened!' }
        format.json { render json: {error: 'Something happened!'} }
      end
      format.html { redirect_to :cart, notice: 'Dress added to cart.' }
      format.json { head :no_content }
    end
  end

  def add_product
    line_item = @cart.add_product params[:product_id]
    respond_to do |format|
      if line_item
        # line_item.create_customised_dress_order_item details: params[:details]
        session[:order_id] = @cart.id # Save order id to session since it's saved now - check Order.add_dress
      else
        format.html { redirect_to :back, alert: 'Something happened!' }
        format.json { render json: {error: 'Something happened!'} }
      end
      format.html { redirect_to :cart, notice: 'Product added to cart.' }
      format.json { head :no_content }
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

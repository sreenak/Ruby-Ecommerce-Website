class GiftCardsController < ApplicationController
  def index
    authenticate_user!
    @user = current_user
    @gift_cards = @user.gift_cards.page params[:page]
  end

  def new
    @gift = GiftCard.new
    @gift.build_shipping_address
  end

  def create
    params[:quantity].to_i.times {
      @gift = GiftCard.new gift_card_params
      if @gift.save
        @cart.add_gift_card @gift
        session[:order_id] = @cart.id
      else
        flash[:error] = 'There are errors in form!'
        return render :new
      end
    }
    redirect_to cart_path, notice: 'Added Gift Vouchers to cart'

  end

  private
  def gift_card_params
    params[:gift_card].permit(:card_type, :ordered_by, :ordered_for, :deliver_to, :message, :amount_paisas, :currency, shipping_address_attributes: [:name, :address_1, :address_2, :city, :country, :postal_code])
  end
end

class GiftCardsController < ApplicationController
  def index
    authenticate_user!
    @user = current_user
    @gift_cards = @user.gift_cards.page params[:page]
  end

  def new
    @gift = EGiftCard.new
    @p_gift = PGiftCard.new
    @gift.build_shipping_address
    @p_gift.build_shipping_address
  end

  def create
    params[:quantity].to_i.times {
      @gift = EGiftCard.new e_gift_card_params
      if @gift.save
        @cart.add_item @gift, @gift.amount.exchange_to(@currency).to_f, 'Gift Voucher'
        session[:order_id] = @cart.id
      else
        flash[:error] = 'There are errors in form!'
        return render :new
      end
    }
    redirect_to cart_path, notice: 'Added Gift Vouchers to cart'
  end

  def add
    params[:quantity].to_i.times {
      @gift = PGiftCard.new p_gift_card_params
      if @gift.save
        @cart.add_item @gift, @gift.amount.exchange_to(@currency).to_f, 'Gift Voucher'
        session[:order_id] = @cart.id
      else
        flash[:error] = 'There are errors in form!'
        return render :new
      end
    }
    redirect_to cart_path, notice: 'Added Gift Vouchers to cart'
  end

  private
  def e_gift_card_params
    params[:gift_card].permit(:card_type, :ordered_by, :email, :ordered_for, :deliver_to, :message, :amount_paisas, :currency, shipping_address_attributes: [:name, :address_1, :address_2, :city, :country, :postal_code])
  end
  def p_gift_card_params
    params[:gift_card].permit(:card_type, :ordered_by, :ordered_for, :deliver_to, :message, :amount_paisas, :currency, shipping_address_attributes: [:name, :address_1, :address_2, :city, :country, :postal_code])
  end
end

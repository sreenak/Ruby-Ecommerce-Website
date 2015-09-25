class GiftCardsController < ApplicationController
  def index
    authenticate_user!
    @user = current_user
    @gift_cards = @user.gift_cards.order(id: :desc).page(params[:page]).per(10)
  end

  def new
    @gift = EGiftCard.new
    @p_gift = PGiftCard.new
    @p_gift.build_shipping_address
  end

  def create
    params[:quantity].to_i.times {
      @gift = EGiftCard.new e_gift_card_params
      if @gift.save
        @cart.add_item @gift, @gift.amount.exchange_to(@currency).to_f, 'Gift Voucher'
        session[:order_id] = @cart.id
      else
        @p_gift = PGiftCard.new
        @p_gift.build_shipping_address if @p_gift.shipping_address.blank?
        flash[:error] = 'There are errors in form!'
        return render :new
      end
    }
    redirect_to cart_path, notice: 'Added Gift Vouchers to cart'
  end

  def add
    params[:quantity].to_i.times {
      @p_gift = PGiftCard.new(p_gift_card_params)
      if @p_gift.save
        @cart.add_item @p_gift, @p_gift.amount.exchange_to(@currency).to_f, 'Gift Voucher'
        session[:order_id] = @cart.id
      else
        @gift = EGiftCard.new
        @p_gift.build_shipping_address if @p_gift.shipping_address.blank?
        flash[:error] = 'There are errors in form!'
        return render :new
      end
    }
    redirect_to cart_path, notice: 'Added Gift Vouchers to cart'
  end

  private
  def e_gift_card_params
    params[:e_gift_card].permit(:ordered_by, :email, :ordered_for, :deliver_to, :message, :amount, :currency)
  end

  def p_gift_card_params
    params[:p_gift_card].permit(:ordered_by, :ordered_for, :deliver_to, :message, :amount, :currency, shipping_address_attributes: [:name, :address_1, :address_2, :id, :_destroy, :city, :country, :postal_code])
  end
end

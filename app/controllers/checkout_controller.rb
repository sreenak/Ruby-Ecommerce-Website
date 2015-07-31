class CheckoutController < ApplicationController
  before_action :set_order, except: :ipn
  before_action :authenticate_user!, only: [:addresses, :pay]

  def user
    @user = User.new
  end

  def process_user
    @user = User.find_by_email user_params[:email]
    if @user
      sign_in(:user, @user)
      redirect_to checkout_addresses_path
    else
      logger.info user_params.inspect
      @user = User.new user_params
      unless verify_recaptcha(message: nil)
        flash.delete :recaptcha_error
        flash[:alert] = 'Captcha verification failed!'
        return render :user
      end
      require 'securerandom'
      password = SecureRandom.hex(8)
      @user.password = password
      # @user.skip_confirmation!
      if @user.save
        UserMailer.auto_create_welcome(@user, password).deliver_later
        sign_in :user, @user
        @order.update user_id: @user.id
        redirect_to checkout_addresses_path
      else
        render :user
        # redirect_to :back, alert: 'Something happened. Please try again!'
      end
    end
  end

  def addresses
    if @order.billing_address.blank?
      if current_or_null_user.billing_address.present?
        @order.build_billing_address(current_or_null_user.billing_address.attributes)
      else
        @order.build_billing_address
      end
    end
    if @order.shipping_address.blank?
      if current_or_null_user.shipping_address.present?
        @order.build_shipping_address(current_or_null_user.shipping_address.attributes)
      else
        @order.build_shipping_address
      end
    end
  end

  def pay
    if @order.update order_params
      if current_user.billing_address.blank?
        current_user.create_billing_address(@order.billing_address.dup.attributes)
      end
      if current_user.shipping_address.blank?
        current_user.create_shipping_address(@order.shipping_address.dup.attributes)
      end
      # @cart.calculate_shipping
      if @order.total = 0
        redirect_to checkout_thank_you_path
      end
      require 'hdfc'
      gateway = Hdfc.new '9002033', 'password1', checkout_thank_you_url, checkout_thank_you_url
      gateway.prepare @order.total, @order.id
      redirect_to gateway.payment_page
    else
      flash[:alert] = 'Billing and shipping address fields are required!'
      render :addresses
    end
  end

  def ipn
  end

  def thank_you
    @order.status = 'Paid'
    @order.created_at = Time.now # This will behave as paid time from now on
    @order.save
    @order.gift_cards.each { |g| g.update status: 'Active' } # Set all gift items to be usable
    session.delete :order_id
    @cart = Cart.new current_or_null_user.id, session[:order_id], session[:currency] # Start a new cart
  end

  private
  def set_order
    @order = @cart.order
  end

  def user_params
    params[:user].permit :name, :email, :phone, :tos
  end

  def order_params
    params[:order].permit billing_address_attributes: [:name, :address_1, :address_2, :city, :country, :postal_code], shipping_address_attributes: [:name, :address_1, :address_2, :city, :country, :postal_code]
  end
end

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
      update_cart_on_login
      redirect_to checkout_addresses_path
    else
      @user = User.new user_params
      unless verify_recaptcha(message: nil)
        flash.delete :recaptcha_error
        flash[:alert] = 'Captcha verification failed!'
        @user.valid?
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
    @currency=session[:currency]
    logger.info @currency.inspect
  end

   def pay
    if @order.update order_params
       @order.update_attributes(:invoice_id => rand.to_s[2..11])
      if current_user.billing_address.blank?
        current_user.create_billing_address(@order.billing_address.dup.attributes)
      end
      if current_user.shipping_address.blank?
        current_user.create_shipping_address(@order.shipping_address.dup.attributes)
      end
      # @cart.calculate_shipping
      if @order.total == 0
        return redirect_to checkout_thank_you_path
      end
      # if !params['payment'].present?
      #   return redirect_to :back, notice: 'Select Payment Gateway!'
      # end
      # if params['payment']=='paypal'
        @order.order_statuses.create(status_type: 1)
        item_details=[]
        @order.line_items.each do |item|
          item_details << {:name => item.title, :quantity => item.quantity, :amount => item.amount.exchange_to('USD').fractional}

        end
        logger.info item_details.inspect
        response = EXPRESS_GATEWAY.setup_purchase(@cart.total.exchange_to('USD').fractional,
                                                  :ip => request.remote_ip,
                                                  :currency =>"USD",
                                                  :items => item_details,
                                                  :order_id => @order.invoice_id,
                                                  :return_url => checkout_thank_you_url,
                                                  :cancel_return_url => cart_url
        )
        logger.info response.inspect

        return redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
      # else
      #   return redirect_to 'https://www.payumoney.com/'
      # end
    else
      flash[:alert] = 'Billing and shipping address fields are required!'
      render :addresses
    end
  end

  def thank_you
    @order = Order.find(session[:order_id])
    logger.info @order.inspect
    @user = current_user.email
    details = EXPRESS_GATEWAY.details_for(params[:token])
    response = EXPRESS_GATEWAY.purchase(@cart.total.fractional, {
        ip: request.remote_ip,
        token: params[:token],
        payer_id: details.payer_id,
        items: @order.line_items.map{|l| {name: l.title, quantity: l.quantity, amount: l.amount.fractional}}
    })
    if response.success?
      # logger.info payment_params.inspect
      payment_params = {gateway: 'PayPal Express Checkout', transaction_id: response.params['token'], ip: request.remote_ip, amount: response.params['gross_amount']}

      # @order.payments.create payment_params
      @cart.order.created_at = DateTime.now
      @cart.order.status = 'Paid'
      @cart.order.save
      session.delete :order_id
      OrderMailer.order_confirmation(@order).deliver_later
     # OrderMailer.admin_receipt(@order).deliver
    else
      redirect_to :cart_checkout, alert: 'Something went wrong. Please try again. If the problem persists, please contact us.'
    end
      @cart = Cart.new current_or_null_user.id, session[:order_id], session[:currency] # Start a new cart
  end

 def payu
      @transaction_id = @cart.id
      @payment_url = ENV['PAYU_MODE'] == 'test' ? 'https://test.payu.in/_payment' : 'https://secure.payu.in/_payment'
      string = "#{ENV['PAYU_KEY']}|#{@transaction_id}|#{@cart.total}|Kaapad|#{current_user.name}|#{current_user.email}|#{@cart.id}||||||||||#{ENV['PAYU_SALT']}"
      logger.info 'string' +string
      @hash = Digest::SHA512.hexdigest(string)
 end   

  def thank_you_payu
      @order=Order.find params[:txnid]
      # logger.info @order.inspect
      @cart.order.created_at = DateTime.now
      @cart.order.status = 'Paid'
      @cart.order.user_id= @order.user_id
      @cart.order.currency= @order.currency
      @cart.order.total_paisas= @order.total_paisas
      @cart.order.invoice_id= @order.invoice_id
      @cart.order.save
      OrderMailer.order_confirmation(@order).deliver_later
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

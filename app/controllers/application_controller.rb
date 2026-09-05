require 'mailchimp'
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :configure_devise_params, if: :devise_controller?
  before_filter :store_location
  before_filter :setup_kaapad

  layout :layout_by_resource

  add_crumb 'Home', '/'

  protect_from_forgery with: :exception
  before_action :setup_mcapi
  def setup_mcapi
    @mc =  Mailchimp::API.new(ENV['MAILCHIMP_API_KEY'])
    @list_id = ENV['MAILCHIMP_LIST_ID']
  end
  
  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :name, :mobile, :tos)
    end
  end

  def store_location
    # store last url for all html get requests
    if request.fullpath !~ /\/user/ && request.method == 'GET' && request.format.symbol == :html
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    update_cart_on_login
    session[:previous_url] || root_path
  end

  def update_cart_on_login
    if session[:order_id]
      order = Order.find_by_id session[:order_id]
      if order and order.user.blank?
        order.update user_id: current_user.id
      end
      in_cart_orders = current_user.orders.where(status: 'In Cart').order(created_at: :desc)
      if in_cart_orders.size > 1
        current_order = in_cart_orders.first
        in_cart_orders.each do |o|
          unless o.id == current_order.id # We are merging to current order, so skip it
            o.line_items.each do |l|
              l.update order_id: current_order.id
            end
            o.delete
          end
        end
        Cart.new(current_user.id, current_order.id).calculate
      end
    end
  end

  def current_or_null_user
    if current_user == nil
      User.new
    else
      current_user
    end
  end

  # Send 'em back where they came from with a slap on the wrist
  def authority_forbidden(error)
    Authority.logger.warn(error.message)
    if current_user.present?
      redirect_to request.referrer.presence || root_path, alert: "You don't have access to that page!"
    else
      redirect_to :new_user_session, alert: 'You need to be logged in to do that!'
    end
  end

  private
  def layout_by_resource
    if devise_controller?
      'auth'
    else
      'application'
    end
  end

  def setup_kaapad
    @category = Category.where('name=? or name=? or name=?','Salwars','Dresses','Gown')
    # session.delete(:cu.where("id = 2")
    if session[:currency].present?
      @currency = session[:currency]
    else
      GeoIp.api_key = 'c50f0486b66be28a5b1f4146b7e13699fbe4e2d437cabebe4fc94327119f81dd'
      ip_address = request.remote_ip

      geo_location = GeoIp.geolocation(ip_address, :precision => :country)
      country_name = geo_location[:country_name]
      Rails.logger.info "Country: #{country_name}"
      if country_name != 'India'
        @currency = 'USD'
        session[:currency] = 'USD'
      else
        @currency = 'INR'
        session[:currency] = 'INR'
      end
    end

    cache = Rails.root.join('vendor', 'currency_rates.xml')

    if !File.exist?(cache) or File.mtime(cache) < Time.now - 1.days
      Money.default_bank.save_rates(cache)
    end

    Money.default_bank.update_rates(cache)


    @cart = Cart.new current_or_null_user.id, session[:order_id], session[:currency]
  end
end

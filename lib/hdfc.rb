class Hdfc
  INR = 356

  attr_reader :transportal_id, :transportal_password, :redirect_url, :error_url, :payment_id, :payment_page, :gateway_url

  def initialize(transportal_id, transportal_password, redirect_url, error_url, mode = 'TEST')
    @transportal_id = transportal_id
    @transportal_password = transportal_password
    @redirect_url = redirect_url
    @error_url = error_url
    @mode = mode
    if mode == 'TEST'
      @gateway_url = 'https://securepgtest.fssnet.co.in/pgway/servlet/PaymentInitHTTPServlet'
    else
      @gateway_url = 'https://securepgtest.fssnet.co.in/pgway/servlet/PaymentInitHTTPServlet'
    end
  end

  def prepare(amount, order_id, data = [], action = 1, currency = Hdfc::INR)
    # Fill in blank UDF fields
    if data.length < 4
      (1..(4-data.length)).each { |i| data << 'None' }
    end

    # Add computed hash to the end of user defined data
    require 'digest'
    data << Digest::SHA256.hexdigest(@transportal_id.to_s + order_id.to_s + amount.to_s + currency.to_s + action.to_s)
    udf = data.map.with_index { |field, i| 'udf' + (i + 1).to_s + '=' + field }.join '&'
    hdfc_params = 'id=' + @transportal_id.to_s + '&password='+@transportal_password+'&action='+action.to_s+'&langid='+'&USA'+ '&currencycode='+currency.to_s+'&amt='+amount.to_s+'&responseURL='+@redirect_url+'&errorURL='+@error_url+'&trackid='+order_id.to_s+'&'+udf
    require 'uri'
    require 'net/http'
    require 'net/https'
    uri = URI.parse @gateway_url
    http = Net::HTTP.new uri.host, uri.port
    http.use_ssl = true
    http.ssl_version = :TLSv1
    request = Net::HTTP::Post.new uri.path
    request.body = hdfc_params
    response = http.request(request)
    if response.body.include? 'ERROR'
      raise Exception, response.body
    end

    response_data = response.body.split ':', 2
    @payment_id = response_data[0]
    @payment_page = response_data[1] + '?PaymentID=' + @payment_id
    @payment_id
  end
end
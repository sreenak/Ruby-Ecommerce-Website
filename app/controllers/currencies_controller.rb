class CurrenciesController < ApplicationController
  def switch
    @cart.convert params[:currency]
    session[:currency] = params[:currency]
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end
end

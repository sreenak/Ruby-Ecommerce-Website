class CurrenciesController < ApplicationController
  def switch
    @cart.convert params[:currency]
    session[:currency] = params[:currency]
    redirect_to :back
  end
end

class ShopController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(8)
  end

  def show
    @product = Product.friendly.find params[:id]
  end
end

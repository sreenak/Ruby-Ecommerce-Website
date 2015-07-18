class DressesController < ApplicationController
  def index
    @products = Product.page params[:page]
  end

  def show
    @product = Product.friendly.find params[:id]
  end
end

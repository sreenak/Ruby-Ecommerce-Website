class ShopController < ApplicationController
  def index
    # @q = Product.ransack(params[:q])
    # @product_search = @q.result(distinct: true)
    @products = Product.page(params[:page]).per(8) 
  end
  def show
    @product = Product.friendly.find params[:id]
    @product_images = @product.product_images.all
    @product_colors = @product.colors.all
    @product_sizes = @product.standard_sizes.all
  end
  def search
    index
    render :index
  end
end

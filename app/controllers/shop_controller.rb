class ShopController < ApplicationController
  def index
    @product_search = Product.ransack(params[:q])
    @products = @product_search.result(distinct: true).page(params[:page]).per(8)
    @product_search.build_sort if @product_search.sorts.empty?
  end

  def show
    @product = Product.friendly.find params[:id]
    @product_images = @product.product_images.all
    @product_colors = @product.colors.all
    @product_sizes = @product.standard_sizes.all
  end
end

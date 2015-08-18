class ShopController < ApplicationController
  def index
    @product_search = Product.ransack(search_params)
    @products = @product_search.result(distinct: true).order(id: :desc).page(params[:page]).per(9)
    @product_search.build_sort if @product_search.sorts.empty?
  end

  def show
    @product = Product.friendly.find params[:id]
    @product_images = @product.product_images.all
    @product_colors = @product.colors.all
    @standard_sizes = @product.standard_sizes.all
    @review = Review.new
    @reviews = @product.reviews.active
  end

  private
  def search_params
    if params[:price].present?
      params[:q] = {} unless params[:q].present?
      params[:q][:price_paisas_gt], params[:q][:price_paisas_lt] = params[:price].split(';').map { |p| p.to_f.to_money(@currency).exchange_to('INR').to_f * 100 }
    end
    params[:q]
  end
end

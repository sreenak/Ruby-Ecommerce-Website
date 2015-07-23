class SearchController < ApplicationController
  def index
  params[:q] ||= { }
  @product_search = Product.ransack(params[:q])
  @products = @product_search.result
  end
end

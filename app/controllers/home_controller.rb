class HomeController < ApplicationController
  def show
    @trends = Post.limit(2)
    @products = Product.featured.limit(6)
    # @standard_sizes = @products.standard_sizes
  end
end

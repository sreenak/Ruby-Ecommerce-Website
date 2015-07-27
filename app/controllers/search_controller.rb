class SearchController < ApplicationController
  def index
    q = params[:q]
    @key=q
    @trends   = Post.search(title_cont: q).result
    @products = Product.search(name_or_description_cont: q).result
  end
end

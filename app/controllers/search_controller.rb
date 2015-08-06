class SearchController < ApplicationController
  def index
    q = params[:q]
    @key = q
    @trends = Post.ransack(title_or_body_cont: q).result(distinct: true).page(params[:page]).per(6)
    @products = Product.ransack(name_cont: q).result(distinct: true).page(params[:page]).per(6)
  end
end

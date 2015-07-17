class TrendsController < ApplicationController
  def index
    @featured_trends = Post.featured.limit 3
    @regular_trends = Post.regular.page(params[:page]).per(8)
  end

  def show
    @trend = Post.friendly.find params[:id]
  end
end

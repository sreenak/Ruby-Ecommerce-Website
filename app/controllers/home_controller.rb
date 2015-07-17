class HomeController < ApplicationController
  def show
    @trends = Post.limit(2)
  end
end

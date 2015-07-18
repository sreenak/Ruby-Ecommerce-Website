class CustomiseController < ApplicationController
  def index
    @dresses = Dress.page params[:page]
  end

  def show
    @dress = Dress.friendly.find params[:id]
  end
end

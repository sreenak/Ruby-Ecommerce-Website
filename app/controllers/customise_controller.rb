class CustomiseController < ApplicationController
  def index
    @dresses = Dress.page params[:page]
  end

  def show
    @dress = Dress.friendly.find params[:id]
    @dress_details_url = customise_url(@dress,format: :json)
  end
end

class CustomiseController < ApplicationController
  def index
    @salwars = Dress.where("category_id = 2").page params[:page]
    @pants = Dress.where("category_id = 3").page params[:page]
  end

  def show
    @dress = Dress.friendly.find params[:id]
    @dress_details_url = customise_url(@dress,format: :json)
  end

end

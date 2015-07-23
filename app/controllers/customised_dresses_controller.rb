class CustomisedDressesController < ApplicationController
  before_filter :authenticate_user!

  # /GET customised_dresses
  def index
    @customised_dresses = current_or_null_user.customised_dresses.where dress_id: params[:id]
    respond_to do |format|
      format.json { render json: @customised_dresses.to_json(:only => [:user_id, :dress_id, :details], methods: [:angle_0,:angle_90,:angle_180,:angle_270]) }
    end
  end

# /POST customised_dresses
  def create
    @customised_dress = current_or_null_user.customised_dresses.new(customised_dress_params)
    respond_to do |format|
      if @customised_dress.save
        format.html { redirect_to :back, notice: 'Customised dress has been successfully saved.' }
        format.json { head :no_content }
      else
        format.html { redirect_to :back, alert: 'Customised dress was not saved.' }
        format.json { render json: {error: @customised_dress.errors}, status: 422 }
      end
    end
  end
  

  # /GET customised_dresses/delete
  def destroy
    @customised_dresses = CustomisedDress.destroy
    format.html { redirect_to :back, notice: 'Customised dress has been successfully destroyed.' }
    format.json { head :no_content }
  end

  private
  def customised_dress_params
    params.permit :dress_id, :angle_0_data_uri, :angle_90_data_uri,:angle_180_data_uri,:angle_270_data_uri, :details
  end

  
end

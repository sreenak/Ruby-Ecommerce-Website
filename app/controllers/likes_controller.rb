class LikesController < ApplicationController
  before_action :authenticate_user!, except: :create

  def index
    @likes = current_user.likes.page(params[:page]).per(12)
  end

  def create
    if user_signed_in?
      Like.where(user_id: current_user.id, product_id: params[:id]).first_or_create
      redirect_to :back, notice: 'You liked the product!'
    else
      redirect_to :back, alert: 'You need to be logged in to like product!'
    end
  end

  def destroy
    @like = Like.where(user_id: current_user.id, product_id: params[:id]).first
    respond_to do |format|
      if @like.present?
        @like.destroy
        format.html { redirect_to :back, notice: 'You unliked item.' }
      else
        format.html { redirect_to :back, notice: 'You have no liked item.' }
      end
    end
  end
end


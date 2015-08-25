class LikesController < ApplicationController
  before_action :authenticate_user!, except: :create

  def index
    @likes = current_user.likes.order(id: :desc).page(params[:page]).per(3)
  end

  def create
    if user_signed_in?
      @like = Like.where(user_id: current_user.id, product_id: params[:id]).first_or_create
      redirect_to :back, notice: "You liked #{@like.product.name}"
    else
      redirect_to new_user_session_path, alert: 'You need to be logged in or signed in to like product!'
    end
  end

  def destroy
    @like = Like.where(user_id: current_user.id, product_id: params[:id]).first
    respond_to do |format|
      if @like.present?
        @like.destroy
        format.html { redirect_to :likes, notice: "You unliked #{@like.product.name}." }
      else
        format.html { redirect_to :likes, notice: 'You have no liked item.' }
      end
    end
  end
end


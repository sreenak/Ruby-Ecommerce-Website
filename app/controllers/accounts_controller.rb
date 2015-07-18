class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    if @user.update user_params
      respond_to do |format|
        format.html { redirect_to :account, notice: 'Account successfully updated.' }
      end
    else
      respond_to do |format|
        format.html { render :edit }
      end
    end
  end

  def orders
  end

  def likes
  end

  def customisations
  end

  def shipping
  end

  private
  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :gender, :date_of_birth, :image, :image_cache, :remove_image)
  end
end

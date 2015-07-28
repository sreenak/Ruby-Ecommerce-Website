class ReviewsController <ApplicationController
  before_action :authenticate_user!, except: :create
  before_action :set_product
  before_action :set_review, only: [:update, :destroy]

  def create
    if user_signed_in?
      @review = @product.reviews.build(review_params)
      if @review.save
        redirect_to :back, notice: "You reviewed #{@review.product.name}"
      else
        redirect_to :back, alert: 'Some Error!'
      end
    else
      redirect_to :back, alert: 'You need to be logged in to review product!'
    end
  end

  def update
    if user_signed_in?
      if  @review.update(review_params)
        redirect_to :back, notice: "Your review for #{@review.product.name} updated successfully"
      else
        redirect_to :back, alert: 'Some Error!'
      end
    else
      redirect_to :back, alert: 'You need to be logged in to review product!'
    end
  end

  def destroy
    @review.destroy
    format.html { redirect_to :back, notice: "You deleted your review for  #{@review.product.name}." }
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find params[:product_id]
  end

  def set_review
    @review = @product.reviews.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def review_params
    params[:review].permit(:user_id, :name, :email, :message)
  end
end
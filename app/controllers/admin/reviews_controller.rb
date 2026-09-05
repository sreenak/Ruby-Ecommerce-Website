class Admin::ReviewsController < AdminController
  add_crumb('Reviews') { |instance| instance.send :admin_reviews_path }
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /admin/pages
  def index
    @reviews = Review.page params[:review]
  end

  # GET /admin/pages/1
  def show
  end

  # GET /admin/pages/new
  # def new
  #   @post = Post.new
  # end

  # GET /admin/pages/1/edit
  def edit
  end

  # POST /admin/pages
  # def create
  #   @post = Post.new(post_params)
  #
  #   if @post.save
  #     redirect_to admin_posts_path, notice: 'Post was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  # PATCH/PUT /admin/pages/1
  def update
    if @review.update(review_params)
      redirect_to admin_reviews_path, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/pages/1
  def destroy
    @review.destroy
    redirect_to admin_reviews_path, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def review_params
      params[:review].permit(:active,:message)
    end
end

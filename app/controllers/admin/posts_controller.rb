class Admin::PostsController < AdminController
  add_crumb('Posts') { |instance| instance.send :admin_posts_path }
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /admin/pages
  def index
    @posts = Post.page params[:post]
  end

  # GET /admin/pages/1
  def show
  end

  # GET /admin/pages/new
  def new
    @post = Post.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # POST /admin/pages
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to admin_posts_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/pages/1
  def update
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/pages/1
  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params[:post].permit(:title, :body, :image, :slug, :featured)
    end
end

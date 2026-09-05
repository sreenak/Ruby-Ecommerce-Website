class Admin::ColorsController < AdminController
  add_crumb('Colors') { |instance| instance.send :admin_colors_path }
  before_action :set_color, only: [:show, :edit, :update, :destroy]

  # GET /admin/pages
  def index
    @colors = Color.page params[:color]
  end

  # GET /admin/pages/1
  def show
  end

  # GET /admin/pages/new
  def new
    @color = Color.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # Color /admin/pages
  def create
    @color = Color.new(color_params)

    if @color.save
      redirect_to admin_colors_path, notice: 'Color was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/pages/1
  def update
    if @color.update(color_params)
      redirect_to admin_colors_path, notice: 'Color was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/pages/1
  def destroy
    @color.destroy
    redirect_to admin_colors_path, notice: 'Color was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color
      @color = Color.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def color_params
      params[:color].permit(:name, :image)
    end
end

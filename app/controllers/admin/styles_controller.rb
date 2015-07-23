class Admin::StylesController < AdminController
  add_crumb('Styles') { |instance| instance.send :admin_styles_path }
  before_action :set_style, only: [:show, :edit, :update, :destroy]

  # GET /admin/pages
  def index
    @styles = Style.page params[:Style]
  end

  # GET /admin/pages/1
  def show
  end

  # GET /admin/pages/new
  def new
    @style = Style.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # Style /admin/pages
  def create
    @style = Style.new(style_params)

    if @style.save
      redirect_to admin_styles_path, notice: 'Style was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/pages/1
  def update
    if @style.update(style_params)
      redirect_to admin_styles_path, notice: 'Style was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/pages/1
  def destroy
    @style.destroy
    redirect_to admin_styles_path, notice: 'Style was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_style
      @style = Style.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def style_params
      params[:style].permit(:name, :image)
    end
end

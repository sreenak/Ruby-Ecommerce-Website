class Admin::PagesController < AdminController
  add_crumb('Pages') { |instance| instance.send :admin_pages_path }
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /admin/pages
  def index
    @pages = Page.page params[:page]
  end

  # GET /admin/pages/1
  def show
  end

  # GET /admin/pages/new
  def new
    @page = Page.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # POST /admin/pages
  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to admin_pages_path, notice: 'Page was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/pages/1
  def update
    if @page.update(page_params)
      redirect_to admin_pages_path, notice: 'Page was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/pages/1
  def destroy
    @page.destroy
    redirect_to admin_pages_path, notice: 'Page was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def page_params
      params[:page].permit(:title, :body)
    end
end

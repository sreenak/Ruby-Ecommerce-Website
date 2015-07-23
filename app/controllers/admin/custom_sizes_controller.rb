class Admin::CustomSizesController < AdminController
  add_crumb('Custom Sizes') { |instance| instance.send :admin_custom_sizes_path }
  before_action :set_size, only: [:show, :edit, :update, :destroy]

  # GET /admin/pages
  def index
    @custom_sizes = CustomSize.page params[:size_params]
  end

  # GET /admin/pages/1
  def show
  end

  # GET /admin/pages/new
  def new
    @custom_size = CustomSize.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # POST /admin/pages
  def create
    @custom_size = CustomSize.new(size_params)

    if @custom_size.save
      redirect_to admin_custom_sizes_path, notice: 'Custom Size was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/pages/1
  def update
    if @custom_size.update(size_params)
      redirect_to admin_custom_sizes_path, notice: 'Custom Size was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/pages/1
  def destroy
    @custom_size.destroy
    redirect_to admin_custom_sizes_path, notice: 'Custom Size was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_size
    @custom_size = CustomSize.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def size_params
    params[:size].permit(:name, :size, :unit)
  end
end
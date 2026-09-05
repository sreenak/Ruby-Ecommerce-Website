class Admin::FabricsController < AdminController
  add_crumb('Fabrics') { |instance| instance.send :admin_fabrics_path }
  before_action :set_fabric, only: [:show, :edit, :update, :destroy]

  # GET /admin/pages
  def index
    @fabrics = Fabric.page params[:fabric]
  end

  # GET /admin/pages/1
  def show
  end

  # GET /admin/pages/new
  def new
    @fabric = Fabric.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # FABRIC /admin/pages
  def create
    @fabric = Fabric.new(fabric_params)

    if @fabric.save
      redirect_to admin_fabrics_path, notice: 'Fabric was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/pages/1
  def update
    if @fabric.update(fabric_params)
      redirect_to admin_fabrics_path, notice: 'Fabric was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/pages/1
  def destroy
    @fabric.destroy
    redirect_to admin_fabrics_path, notice: 'Fabric was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_fabric
    @fabric = Fabric.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def fabric_params
    params.require(:fabric).permit(:name, fabric_colors_attributes: [:name, :swatch, :swatch_cache, :remove_swatch, :id, :_destroy])
  end
end

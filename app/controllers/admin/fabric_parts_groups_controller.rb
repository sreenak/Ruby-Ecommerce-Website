class Admin::FabricPartsGroupsController < AdminController
  before_action :set_dress
  before_action :set_parts_groups, only: [:show, :edit, :update, :destroy]

  # GET /admin/shipments
  def index
    @fabric_parts_groups = @dress.fabric_parts_groups.page params[:dress]
  end

  # GET /admin/shipments/1
  def show
  end

  # GET /admin/shipments/new
  def new
    @fabric_parts_group = FabricPartsGroup.new
  end

  # GET /admin/shipments/1/edit
  def edit
  end

  # POST /admin/shipments
  def create
    @fabric_parts_group = @dress.fabric_parts_groups.new(parts_groups_params)
    @fabric_parts_group.save
    redirect_to admin_dress_fabric_parts_groups_path(@dress), notice: 'Fabric Group was successfully created.'
  end

  # PATCH/PUT /admin/shipments/1
  def update
    if @fabric_parts_group.update(parts_groups_params)
      redirect_to admin_dress_fabric_parts_groups_path(@dress), notice: 'Fabric Group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/shipments/1
  def destroy
    @fabric_parts_group.destroy
    redirect_to admin_dress_fabric_parts_groups_path(@dress), notice: 'Shippings was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_dress
    @dress = Dress.friendly.find(params[:dress_id])
  end

  def set_parts_groups
    @fabric_parts_group = @dress.fabric_parts_groups.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def parts_groups_params
    params[:fabric_parts_group].permit(:name, :svg_group_id, :id,
                                       fabric_group_colors_attributes: [
                                           :fabric_color_id, :id, :_destroy, :price, embellishment_ids: [],
                                       ],
                                       parts_attributes: [
                                           :id, :_destroy, :name, :svg_path_id, brocade_parts_attributes: [:brocade_id, :id, :_destroy, :image, :image_cache, :price, embellishment_ids: []]
                                       ])
  end
end
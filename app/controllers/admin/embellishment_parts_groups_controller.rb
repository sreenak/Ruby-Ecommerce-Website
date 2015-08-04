class Admin::EmbellishmentPartsGroupsController < AdminController
  before_action :set_dress
  before_action :set_parts_groups, only: [:show, :edit, :update, :destroy]

  # GET /admin/shipments
  def index
    @embellishment_parts_groups = @dress.embellishment_parts_groups.page params[:dress]
  end

  # GET /admin/shipments/1
  def show
  end

  # GET /admin/shipments/new
  def new
    @embellishment_parts_group = EmbellishmentPartsGroup.new
  end

  # GET /admin/shipments/1/edit
  def edit
  end

  # POST /admin/shipments
  def create
    @embellishment_parts_group = @dress.embellishment_parts_groups.new(parts_groups_params)
    @embellishment_parts_group.save
    redirect_to admin_dress_embellishment_parts_groups_path(@dress), notice: 'Embellishment Group was successfully created.'
  end

  # PATCH/PUT /admin/shipments/1
  def update
    if @embellishment_parts_group.update(parts_groups_params)
      redirect_to admin_dress_embellishment_parts_groups_path(@dress), notice: 'Embellishment Group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/shipments/1
  def destroy
    @embellishment_parts_group.destroy
    redirect_to admin_dress_embellishment_parts_groups_path(@dress), notice: 'Embellishment was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_dress
    @dress = Dress.friendly.find(params[:dress_id])
  end

  def set_parts_groups
    @embellishment_parts_group = @dress.embellishment_parts_groups.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def parts_groups_params
    params[:embellishment_parts_group].permit(:name, :svg_group_id, :id,
                                               parts_attributes: [
                                                   :id, :_destroy, :name, :svg_path_id, embellishment_parts_attributes: [:embellishment_id, :id, :_destroy,:price, :image, :image_cache]
                                               ])
  end
end
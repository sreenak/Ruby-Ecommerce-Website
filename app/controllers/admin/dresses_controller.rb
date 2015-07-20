class Admin::DressesController < AdminController
  add_crumb('Dresses') { |instance| instance.send :admin_dresses_path }
  before_action :set_dress, only: [:show, :edit, :update, :destroy]

  # GET /admin/pages
  def index
    @dresses = Dress.page params[:dress]
  end

  # GET /admin/pages/1
  def show
  end

  # GET /admin/pages/new
  def new
    @dress = Dress.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # DRESS /admin/pages
  def create
    @dress = Dress.new(dress_params)

    if @dress.save
      redirect_to admin_dresses_path, notice: 'Dress was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/pages/1
  def update
    if @dress.update(dress_params)
      redirect_to admin_dresses_path, notice: 'Dress was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/pages/1
  def destroy
    @dress.destroy
    redirect_to admin_dresses_path, notice: 'Dress was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_dress
    @dress = Dress.friendly.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def dress_params
    params[:dress].permit(
        :name, :sketch, :remove_sketch, :sketch_cache, :category_id, :sku, :base_price,
        :angle_0, :angle_0_cache, :remove_angle_0,
        :angle_90, :angle_90_cache, :remove_angle_90,
        :angle_180, :angle_180_cache, :remove_angle_180,
        :angle_270, :angle_270_cache, :remove_angle_270,
        fabric_parts_groups_attributes:
            [
                :name, :svg_group_id, :id, :_destroy, fabric_color_ids: [],
                parts_attributes: [
                    :id, :_destroy, :name, :svg_path_id, brocade_parts_attributes: [:brocade_id,:id, :_destroy, :image, :image_cache]
                ]
            ],
        embellishment_parts_groups_attributes:
            [
                :name, :svg_group_id,:id, :_destroy,
                parts_attributes: [
                    :id, :_destroy, :name, :svg_path_id, embellishment_parts_attributes: [:embellishment_id,:id, :_destroy, :image, :image_cache]
                ]
            ]
    )
  end
end

class Admin::StylesGroupsController < AdminController
  add_crumb('Dresses') { |instance| instance.send :admin_dresses_path }
  add_crumb('Dresses Style Part Group') { |instance| instance.send :admin_dress_styles_groups_path }
  before_action :set_dress
  before_action :set_parts_groups, only: [:show, :edit, :update, :destroy]

  # GET /admin/shipments
  def index
    @styles_groups = @dress.styles_groups.page params[:dress]
  end

  # GET /admin/shipments/1
  def show
  end

  # GET /admin/shipments/new
  def new
    @styles_group = StylesGroup.new
  end

  # GET /admin/shipments/1/edit
  def edit
  end

  # POST /admin/shipments
  def create
    @styles_group = @dress.styles_groups.new(groups_params)
    @styles_group.save
    redirect_to admin_dress_styles_groups_path(@dress), notice: 'style Group was successfully created.'
  end

  # PATCH/PUT /admin/shipments/1
  def update
    if @styles_group.update(groups_params)
      redirect_to admin_dress_styles_groups_path(@dress), notice: 'style Group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/shipments/1
  def destroy
    @styles_group.destroy
    redirect_to admin_dress_styles_groups_path(@dress), notice: 'style was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_dress
    @dress = Dress.friendly.find(params[:dress_id])
  end

  def set_parts_groups
    @styles_group = @dress.styles_groups.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def groups_params
    params[:styles_group].permit(:name, :svg_group_id, :id,
                                 styles_attributes: [
                                     :id, :_destroy, :name, :svg_path_id, :image
                                 ])
  end
end
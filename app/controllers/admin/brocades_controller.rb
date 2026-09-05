class Admin::BrocadesController < AdminController
  add_crumb('Brocades') { |instance| instance.send :admin_brocades_path }
  before_action :set_brocade, only: [:show, :edit, :update, :destroy]

  # GET /admin/pages
  def index
    @brocades = Brocade.page params[:brocade]
  end

  # GET /admin/pages/1
  def show
  end

  # GET /admin/pages/new
  def new
    @brocade = Brocade.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # BROCADE /admin/pages
  def create
    @brocade = Brocade.new(brocade_params)

    if @brocade.save
      redirect_to admin_brocades_path, notice: 'Brocade was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/pages/1
  def update
    if @brocade.update(brocade_params)
      redirect_to admin_brocades_path, notice: 'Brocade was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/pages/1
  def destroy
    @brocade.destroy
    redirect_to admin_brocades_path, notice: 'Brocade was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brocade
      @brocade = Brocade.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def brocade_params
      params[:brocade].permit(:name, :swatch, :swatch_cache, :remove_swatch)
    end
end

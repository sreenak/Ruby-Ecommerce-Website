class Admin::EmbellishmentsController < AdminController
  add_crumb('Embellishments') { |instance| instance.send :admin_embellishments_path }
  before_action :set_embellishment, only: [:show, :edit, :update, :destroy]

  # GET /admin/pages
  def index
    @embellishments = Embellishment.page params[:embellishment]
  end

  # GET /admin/pages/1
  def show
  end

  # GET /admin/pages/new
  def new
    @embellishment = Embellishment.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # EMBELLISHMENT /admin/pages
  def create
    @embellishment = Embellishment.new(embellishment_params)

    if @embellishment.save
      redirect_to admin_embellishments_path, notice: 'Embellishment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/pages/1
  def update
    if @embellishment.update(embellishment_params)
      redirect_to admin_embellishments_path, notice: 'Embellishment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/pages/1
  def destroy
    @embellishment.destroy
    redirect_to admin_embellishments_path, notice: 'Embellishment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_embellishment
      @embellishment = Embellishment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def embellishment_params
      params[:embellishment].permit(:name, :image, :image_cache, :remove_image)
    end
end

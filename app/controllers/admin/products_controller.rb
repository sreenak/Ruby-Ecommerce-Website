class Admin::ProductsController < AdminController
  add_crumb('Products') { |instance| instance.send :admin_products_path }
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /admin/pages
  def index
    @products = Product.page params[:product]
  end

  # GET /admin/pages/1
  def show
  end

  # GET /admin/pages/new
  def new
    @product = Product.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # PRODUCT /admin/pages
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/pages/1
  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/pages/1
  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: 'Product was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.friendly.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def product_params
    params[:product].permit(:name, :sku, :price, :image, :category_id, :image_cache, :remove_image, :featured, :dress_id, :description,
     product_images_attributes: [:image, :id, :_destroy],
     color_ids: [], product_size_ids: []
     )
  end
end

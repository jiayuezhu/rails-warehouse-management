 class ProductsController < ApplicationController
  before_action :authorize_product, only: [:show, :edit, :update, :destroy]
  def index
    # @products = policy_scope(Product).order(created_at: :desc)
    if params[:query].present?
      @products = policy_scope(Product).search_by("%#{params[:query]}%").select { |product| product.user == current_user }
    else
      @products = policy_scope(Product).paginate(:page => params[:page], :per_page => 30).select { |product| product.user == current_user }
      @low = policy_scope(Product).order( storage: :asc ).select { |product| product.user == current_user }
      @wholesale_products = policy_scope(Product).order( wholesale_sold: :desc ).select { |product| product.user == current_user }
      @retail_products = policy_scope(Product).order( retail_sold: :desc ).select { |product| product.user == current_user }
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new_similar
    old_product = Product.find(params[:id])
    @new_product = Product.new(user_id: current_user.id,
                               name: old_product.name,
                               brand: old_product.brand,
                               model: old_product.model,
                               category: old_product.category,
                               purchase_price: old_product.purchase_price,
                               wholesale_labeled_price: old_product.wholesale_labeled_price)
    authorize @new_product
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(set_product)
    @product.user = current_user
    authorize @product
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = current_user.products.find(params[:id])
    authorize @product
    if @product.update(set_product)
      redirect_to products_path(@product)
      flash[:notice] = "Successfully updated !"
    else
      render :edit
    end
  end

  def destroy
    @product = current_user.products.find(params[:id])
    authorize @product
    @product.destroy
    redirect_to products_path
  end

  # protected

  # def validate_search_key
  #    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
  #    @search_criteria = search_criteria(@query_string)
  # end

  # def search_criteria(query_string)
  #    { title_or_description_cont: query_string }
  # end

  private

  def set_product
    params.require(:product).permit(:name, :photo, :user_id, :model, :category, :color, :storage, :brand, :purchase_price, :retail_price, :retail_labeled_price, :wholesale_labeled_price)
  end

  def authorize_product
    @product = Product.find(params[:id])
    authorize @product
  end

end

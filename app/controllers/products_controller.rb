class ProductsController < ApplicationController
  def index
    # @products = policy_scope(Product).order(created_at: :desc)
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    # authorize @product
  end

  def create
    @product = Product.new(set_product)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def set_product
    params.require(:product).permit(:name, :model, :category, :color, :storage, :brand, :purchase_price, :retail_price, :retail_labeled_price, :wholesale_labeled_price)
  end
end

 class ProductsController < ApplicationController
  def index
    # @products = policy_scope(Product).order(created_at: :desc)
    search = Product.search(params[:query]).to_a
    puts search
    if search.any?
      @products = search
      puts "************************** success ******************************"
    else
      @products = Product.all
      puts "************************** Fuck ******************************"
    end
  end

  # def autocomplete
  #   render json: Product.search(params[:query], {
  #     fields: ["name", "model", "category", "brand"],
  #     match: :word_start,
  #     limit: 10,
  #     load: false,
  #     misspellings: {below: 2}
  #   }).map(&:name)
  # end

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
    params.require(:product).permit(:name, :model, :category, :color, :storage, :brand, :purchase_price, :retail_price, :retail_labeled_price, :wholesale_labeled_price)
  end
end
class DescriptionsController < ApplicationController
  before_action :authorize_description, only: [:edit, :update, :destroy]
  def new
    @product = Product.find(params[:product_id])
    authorize @product
    @description = Description.new
  end

  def create
    @product = Product.find(params[:product_id])
    @description = Description.new(description_params)
    @description.user = current_user
    @description.product = Product.find(params[:product_id])
    authorize @description
    if @description.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit
    @description = Description.find(params[:id])
  end

  def update
    @description = current_user.descriptions.find(params[:id])
    if @description.update(description_params)
      redirect_to descriptions_path(@description)
    else
      render :edit
    end
  end

  def destroy
    @description = current_user.descriptions.find(params[:id])
    @description.user = current_user
    if @description.destroy!
      flash[:notice] = "Successfully deleted !"
    end

  end
  private
  def description_params
    params.require(:description).permit(:product_id, :detail_id, :parameter, :user_id)
  end
  def authorize_description
    @description = Description.find(params[:id])
    authorize @description
  end
end

class DescriptionsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @description = Description.new
  end

  def create
    @product = Product.find(params[:product_id])
    @description = Description.new(description_params)
    @description.product = Product.find(params[:product_id])
    if @description.save
      p params[:product_id]
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit
    @description = Description.find(params[:id])
  end

  def update
    @description = Description.find(params[:id])
    if @description.update(description_params)
      redirect_to descriptions_path(@description)
    else
      render :edit
    end
  end

  def destroy
    @description = Description.find(params[:id])
    @description.destroy
  end
  private
  def description_params
    params.require(:description).permit(:product_id, :detail_id, :parameter)
  end
end

class DetailsController < ApplicationController
  def index
    @details = policy_scope(Detail).select { |product| product.user == current_user }
  end

  def new
    @detail = Detail.new
    authorize @detail
  end

  def create
    @detail = Detail.new(detail_params)
    @detail.user = current_user
    authorize @detail
    if @detail.save
      redirect_to details_path
      flash[:notice] = "Successfully created !"
    end
  end

  def destroy
    @detail = current_user.details.find(params[:id])
    authorize @detail
    @descriptions = policy_scope(Description).where(detail_id: params[:id])
    if @descriptions.any?
      @descriptions.each do |d|
        d.destroy!
      end
    end
    @detail.destroy!
    flash[:notice] = "Successfully deleted !"
    redirect_to details_path
  end

  private

  def detail_params
    params.require(:detail).permit(:id, :name, :user_id)
  end
end

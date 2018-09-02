class DetailsController < ApplicationController
  def index
    @details = Detail.all
  end

  def new
    @detail = Detail.new
  end

  def create
    @detail = Detail.new(detail_params)
    if @detail.save
      redirect_to details_path
    end
  end

  def destroy
    @detail = Detail.find(params[:id])
    @descriptions = Description.where(detail_id: params[:id])
    if @descriptions.any?
      @descriptions.each do |d|
        d.destroy!
      end
    end
    @detail.destroy!
    redirect_to details_path
  end

  private
  def detail_params
    params.require(:detail).permit(:id, :name)
  end
end

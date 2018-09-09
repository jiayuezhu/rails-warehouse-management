class BuyersController < ApplicationController
  before_action :authorize_buyer, only: [:show, :edit_buyer, :edit_seller, :update, :destroy]
  def all_buyers
    if params[:query].present?
      @buyers = policy_scope(Buyer).where(is_buyer: true).search_buyers("%#{params[:query]}%")
      authorize @buyers
    else
      @buyers = policy_scope(Buyer).where(is_buyer: true)
      authorize @buyers
    end
  end

  def all_sellers
    if params[:query].present?
      @buyers = policy_scope(Buyer).where(is_buyer: false).search_buyers("%#{params[:query]}%")
      authorize @buyers
    else
      @buyers = policy_scope(Buyer).where(is_buyer: false)
      authorize @buyers
    end
  end

  def show
    @buyer = Buyer.find(params[:id])
    authorize @buyer
  end

  def new_buyer
    @buyer = Buyer.new(is_buyer: true)
    authorize @buyer
  end

  def new_seller
    @buyer = Buyer.new(is_buyer: false)
    authorize @buyer
  end

  def create
    @buyer = Buyer.new(set_buyer)
    @buyer.user = current_user
    authorize @buyer
    if @buyer.save
      redirect_to buyer_path(@buyer)
    else
      render :new
    end
  end

  def edit_buyer
    @buyer = Buyer.find(params[:id])
  end

  def edit_seller
    @buyer = Buyer.find(params[:id])
  end

  def update
    @buyer = current_user.buyers.find(params[:id])
    authorize @buyer
    if @buyer.update(set_buyer)
      redirect_to buyer_path(@buyer)
      flash[:notice] = "Updated successfully !"
    else
      render :edit
    end
  end

  def destroy
    @buyer = current_user.buyers.find(params[:id])
    authorize @buyer
    if @buyer.destroy
      redirect_to customers_path
      flash[:notice] = "Deleted successfully !"
    end
  end

  private

  def set_buyer
    params.require(:buyer).permit(:name, :is_buyer, :user_id, :phone_number, :wechat_id, :address, :company, :notes, :email, :website)
  end
  def authorize_buyer
    @buyer = Buyer.find(params[:id])
    authorize @buyer
  end
end




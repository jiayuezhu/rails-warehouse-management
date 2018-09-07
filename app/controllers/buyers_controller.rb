class BuyersController < ApplicationController
  def all_buyers
    if params[:query].present?
      @buyers = Buyer.where(is_buyer: true).search_buyers("%#{params[:query]}%")
    else
      @buyers = Buyer.where(is_buyer: true)
    end
  end

  def all_sellers
    if params[:query].present?
      @buyers = Buyer.where(is_buyer: false).search_buyers("%#{params[:query]}%")
    else
      @buyers = Buyer.where(is_buyer: false)
    end
  end

  def show
    @buyer = Buyer.find(params[:id])
  end

  def new_buyer
    @buyer = Buyer.new(is_buyer: true)
  end

  def new_seller
    @buyer = Buyer.new(is_buyer: false)
  end

  def create
    @buyer = Buyer.new(set_buyer)
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
    @buyer = Buyer.find(params[:id])
    if @buyer.update(buyer_params)
      redirect_to buyers_path(@buyer)
    else
      render :edit
    end
  end

  def destroy
    @buyer = Buyer.find(params[:id])
    @buyer.destroy
    redirect_to buyers_path
  end

  private

  def set_buyer
    params.require(:buyer).permit(:name, :is_buyer, :phone_number, :wechat_id, :address, :company, :notes, :email)
  end

end

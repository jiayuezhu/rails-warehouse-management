class ListsController < ApplicationController
  before_action :authorize_list, only: [:show, :edit_retail, :edit_wholesale, :edit_purchase, :update, :destroy]
  before_action :authorize_bill, only: [:new_purchase, :new_wholesale, :new_retail, :create]
  def index
    @lists = policy_scope(List).order(created_at: :desc).select { |product| product.user == current_user }
  end

  def new_retail
    @bill = Bill.find(params[:bill_id])
    @list = List.new(buyer_id: Buyer.find_by(name: "lingshoukehu").id)
    authorize @list
  end

  def new_wholesale
    @bill = Bill.find(params[:bill_id])
    @list = List.new
    authorize @list
  end

  def new_purchase
    @bill = Bill.find(params[:bill_id])
    @list = List.new
    authorize @list
  end

  def show
    @list = List.find(params[:id])
    @buyer = @list.buyer
    @bill = Bill.find(@list.bill_id)
    @wholesale = Wholesale.new
    authorize @wholesale
  end

  def create
    @bill = Bill.find(params[:bill_id])
    @list = List.new(list_params)
    @list.user = current_user
    authorize @list
    if @list.save
      redirect_to list_path(@list)
      flash[:notice] = "Successfully added"
    else
      redirect_to bills_path
      flash[:alert] = "Failed to add. Please try again."
    end
  end

  def edit_retail
    @list = List.find(params[:id])
  end

  def edit_wholesale
    @list = List.find(params[:id])
  end

  def edit_purchase
    @list = List.find(params[:id])
  end

  def update
    @bill = Bill.find(@list.bill_id)
    @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to bill_path(@bill)
    else
      redirect_to bills_path
      flash[:alert] = "Failed to update. Please try again."
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to bills_path
  end

  private

  def list_params
    params.require(:list).permit(:buyer_id, :seller_id, :user_id, :bill_id, :sub_total, :tax, :price_total, :notes, :created_at)
  end

  def authorize_list
    @list = List.find(params[:id])
    authorize @list
  end
  def authorize_bill
    @bill = Bill.find(params[:bill_id])
    authorize @bill
  end
end





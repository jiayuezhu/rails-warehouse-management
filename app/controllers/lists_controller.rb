class ListsController < ApplicationController
  def index
    @lists = List.all.order(created_at: :desc)
  end

  def new_retail
    @bill = Bill.find(params[:bill_id])
    @list = List.new
  end
  def new_wholesale
    @bill = Bill.find(params[:bill_id])
    @list = List.new
  end
  def new_purchase
    @bill = Bill.find(params[:bill_id])
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    @bill = Bill.find(@list.bill_id)
    @wholesale = Wholesale.new
  end

  def create
    @bill = Bill.find(params[:bill_id])
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
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
    params.require(:list).permit(:buyer_id, :seller_id, :bill_id, :sub_total, :tax, :price_total, :notes, :created_at)
  end
end

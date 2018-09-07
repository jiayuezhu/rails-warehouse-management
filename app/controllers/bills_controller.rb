class BillsController < ApplicationController
  def index
    if params[:query].present?
      @bills = Bill.search_bills("%#{params[:query]}%")
    else
      @bills = Bill.all.order(created_at: :desc)
    end
  end

  def show
    @bill = Bill.find(params[:id])
    @list = List.new(bill_id: params[:id])
  end

  def new
    @bill = Bill.new
  end

  def create
    @bill = Bill.new(bill_params)
    if @bill.save
      redirect_to bill_path(@bill)
    else
      render :new
    end
  end

  def update
    @bill = Bill.find(params[:id])
    if @bill.update(bill_params)
      redirect_to bill_path(@bill)
    else
      flash[:alert] = "Failed to add notes. Please try again."
    end
  end

  private
  def bill_params
    params.require(:bill).permit(:created_at, :notes)
  end
end

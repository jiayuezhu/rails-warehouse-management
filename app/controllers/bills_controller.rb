class BillsController < ApplicationController
  def index
    @bills = Bill.all.order(created_at: :desc)
  end

  def show
    @bill = Bill.find(params[:id])
    @list = List.new(bill_id: params[:id])
  end

  def new
    @bill = Bill.new
  end

  def create
    @bill = Bill.new(params[:id])
    if @bill.save
      redirect_to bill_path(@bill)
    else
      render :new
    end
  end
end

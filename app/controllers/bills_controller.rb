class BillsController < ApplicationController
  def index
    @bills = Bill.all.order(created_at: :desc)
    search = Bill.search(params[:query]).to_a
    puts search
    if search.any?
      @bills = search
      puts "************************** success ******************************"
    else
      @bills = Bill.all
      puts "************************** Fuck ******************************"
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

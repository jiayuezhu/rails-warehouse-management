class BillsController < ApplicationController
  before_action :authorize_bill, only: [:show, :destroy, :update]
  def index
    if params[:query].present?
      @bills = policy_scope(Bill).search_bills("%#{params[:query]}%").select { |bill| bill.user == current_user }
    else
      @bills = policy_scope(Bill).order(created_at: :desc).select { |bill| bill.user == current_user }
    end
  end

  def show
    @bill = Bill.find(params[:id])
    @list = List.new(bill_id: params[:id])
  end

  def new
    @bill = Bill.new
    @bills = policy_scope(Bill).order(created_at: :desc).select { |bill| bill.user == current_user }
    authorize @bill
  end

  def create
    @bill = Bill.new(bill_params)
    @bill.user = current_user
    authorize @bill
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
    params.require(:bill).permit(:created_at, :notes, :user_id)
  end
  def authorize_bill
    @bill = Bill.find(params[:id])
    authorize @bill
  end
end

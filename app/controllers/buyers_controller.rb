class BuyersController < ApplicationController
  def all_buyers
    search = Buyer.search(params[:query]).to_a
    puts search
    if search.any?
      results = []
      search.each do |s|
        if s.is_buyer == true
          results << s
        end
      end
      @buyers = results
      puts "************************** success ******************************"
    else
      @buyers = Buyer.where(is_buyer: true).order(name: :asc)
      puts "************************** Fuck ******************************"
    end
  end

  def all_sellers
    search = Buyer.search(params[:query]).to_a
    puts search
    if search.any?
      results = []
      search.each do |s|
        if s.is_buyer == false
          results << s
        end
      end
      @buyers = results
      puts "************************** success ******************************"
    else
      @buyers = Buyer.where(is_buyer: false).order(name: :asc)
      puts "************************** Fuck ******************************"
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

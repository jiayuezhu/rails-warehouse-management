class WholesalesController < ApplicationController
    # autocomplete :product, :name, :extra_data => [:model]
  def create

    @product = Product.find(params[:wholesale][:product_id])
    @list = List.find(params[:list_id])
    storage = @product.storage
    @product.retail_sold = 0 if @product.retail_sold == nil
    @list.price_total = 0 if @list.price_total == nil
    @list.sub_total = 0 if @list.sub_total == nil
    @product.wholesale_sold = 0 if @product.wholesale_sold == nil
    wholesale_sold = @product.wholesale_sold
    if @list.buyer.is_buyer == true
      if  @product.storage <= 0
        redirect_to list_path(@list)
        flash[:alert] = "Your #{@product.name} is currently out of stock."
      elsif @product.storage == params[:wholesale][:quantity].to_i
        @wholesale = Wholesale.new(wholesale_params)
        @wholesale.user = current_user
        authorize @wholesale
        @wholesale.list = @list
        if @wholesale.save
          @list.update(price_total: @list.price_total + (params[:wholesale][:price].to_f * params[:wholesale][:quantity].to_i).round(2),
                       sub_total: @list.sub_total + ((params[:wholesale][:price].to_f - Product.find(params[:wholesale][:product_id]).purchase_price.to_f) * params[:wholesale][:quantity].to_i).round(2))
          if @list.buyer.name == "lingshoukehu"
            @product.update(storage: storage - @wholesale.quantity, retail_sold: retail_sold += @wholesale.quantity)
          else
            @product.update(storage: storage - @wholesale.quantity, retail_sold: wholesale_sold += @wholesale.quantity)
          end
          redirect_to list_path(@list)
          flash[:notice] = "Successfully saved, but your #{@product.name} is out of stock now!"
        end
      elsif @product.storage <= params[:wholesale][:quantity].to_i
        redirect_to list_path(@list)
        flash[:alert] = "You only have #{@product.storage} #{@product.name}s in stock."
      else
        @wholesale = Wholesale.new(wholesale_params)
        @wholesale.user = current_user
        authorize @wholesale
        @wholesale.list = @list
        if @wholesale.save
          @list.update(price_total: @list.price_total + (params[:wholesale][:price].to_f * params[:wholesale][:quantity].to_i).round(2),
                       sub_total: @list.sub_total + ((params[:wholesale][:price].to_f - Product.find(params[:wholesale][:product_id]).purchase_price.to_f) * params[:wholesale][:quantity].to_i).round(2))
          if @list.buyer.name == "lingshoukehu"
            @product.update(storage: storage - @wholesale.quantity, retail_sold: retail_sold += @wholesale.quantity)
          else
            @product.update(storage: storage - @wholesale.quantity, wholesale_sold: wholesale_sold += @wholesale.quantity)
          end
          redirect_to list_path(@list)
          flash[:notice] = "Successfully saved!"
        end
      end

    elsif @list.buyer.is_buyer == false
      @wholesale = Wholesale.new(wholesale_params)
      @wholesale.user = current_user
      authorize @wholesale
      @wholesale.list = @list
      if @wholesale.save
        @list.update(price_total: @list.price_total + (@product.purchase_price * params[:wholesale][:quantity].to_i).round(2))
        if @list.buyer.name == "lingshoukehu"
          @product.update(storage: storage + @wholesale.quantity)
        end
        redirect_to list_path(@list)
        flash[:notice] = "You have successfully added #{params[:wholesale][:quantity]} to your #{@product.name} !"
      end

    end

  end

  private

  def wholesale_params
    params.require(:wholesale).permit(:id, :product_id, :quantity, :price, :user_id)
  end
end

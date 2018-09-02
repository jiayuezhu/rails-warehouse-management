class WholesalesController < ApplicationController
    # autocomplete :product, :name, :extra_data => [:model]
    def create
      @list = List.find(params[:list_id])
      @wholesale = Wholesale.new(wholesale_params)
      @wholesale.list = @list
      if @wholesale.save
        redirect_to list_path(@list)
      # else
      #   render 'restaurants/show'
    end
  end

  private

  def wholesale_params
    params.require(:wholesale).permit(:id, :product_id, :quantity, :price)
  end
end

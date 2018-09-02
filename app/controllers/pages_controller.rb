class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    search = params[:term].present? ? params[:term] : nil
    if search
      @products = Product.search(search)
      puts "***************************** success *************************************"
    else
      @products = Product.all
      puts "***************************** failed *************************************"
    end
  end
end

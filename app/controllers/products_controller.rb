class ProductsController < ApplicationController

  def index
    @products = Product.where(:is_hidden => false).order("created_at DESC")
  end

  def show
    @product = Product.find(params[:id])
    if @Product.is_hidden
      flash[:warning] = "该产品已下架"
      redirect_to products_path
    end
  end

end

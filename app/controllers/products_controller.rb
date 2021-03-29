class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_param)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def product_param
    params.require(:product).permit(:image, :title, :info, :category_id, :quality_id, :delivery_fee_id, :location_id, :delivery_date_id, :price).merge(user_id: current_user.id)
  end
end
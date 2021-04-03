class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :forbid_edit, only: [:edit, :update, :destroy]

  def index
    @products = Product.order('created_at DESC')
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
  def show
  end

  def edit
  end

  def update
    if @product.update(product_param)
      redirect_to product_path(product_param)
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  private

  def product_param
    params.require(:product).permit(:image, :title, :info, :category_id, :quality_id, :delivery_fee_id, :location_id,
                                    :delivery_date_id, :price).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless @product.user_id == current_user.id
  end

  def forbid_edit
    redirect_to root_path unless @product.order == nil
  end
end

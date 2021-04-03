class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  before_action :move_to_index

  def index
    @order_shipping_address = OrderShippingAddress.new
  end

  def create
    @order_shipping_address = OrderShippingAddress.new(order_shipping_address_param)
    if @order_shipping_address.valid?
      pay_item
      @order_shipping_address.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @product.price,
      card: order_shipping_address_param[:token],
      currency: 'jpy'
    )
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def order_shipping_address_param
    params.require(:order_shipping_address).permit(:postal_address, :state_id, :city, :street, :building, :phone).merge(token: params[:token], product_id: @product.id, user_id: current_user.id)
  end

  def move_to_index
    redirect_to root_path unless @product.user_id != current_user.id && @product.order == nil
  end
end

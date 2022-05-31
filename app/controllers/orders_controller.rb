class OrdersController < ApplicationController
  before_action :set_order, only: [:show]
  before_action :authenticate_user!
  
  def index
    if current_user.admin?
      @orders = Order.all
    else
      id = current_user.carrier_id
      @orders = Order.where("carrier_id == ?", id)
    end
  end

  def new
    @order = Order.new
    @carriers = Carrier.all
  end

  def show; end
  

  def create
    @order = Order.new(order_params)
    if @order.save()
      flash[:notice] = "Ordem cadastrada com sucesso."
      redirect_to @order
    else
      @carriers = Carrier.all
      flash[:notice] = "Ordem não cadastrada."
      render 'new'
    end
  end
  
  private
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:pickup_address, :delivery_address, :height, :width, :length, :weight, :code, :receiver_name, :status, :order, :carrier_id)
  end 
end
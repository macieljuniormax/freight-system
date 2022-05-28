class PricesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @prices = Price.all
  end 

  def new
    @price = Price.new
  end

  def create
    @price = Price.new(price_params)
    @price.carrier = current_user.carrier
    if @price.save()
      flash[:notice] = "Nova faixa de preço cadastrada com sucesso."
      redirect_to prices_path
    else
      flash[:notice] = "Faixa de preço não cadastrada."
      render 'new'
    end
  end

  private
  def price_params
    params.require(:price).permit(:min_volume, :max_volume, :min_weight, :max_weight, :price_km, :carrier)
  end 
end
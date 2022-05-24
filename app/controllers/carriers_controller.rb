class CarriersController < ApplicationController
  def new
    @carrier = Carrier.new
  end

  def show
    @carrier = Carrier.find(params[:id])
  end
  

  def create
    @carrier = Carrier.new(carrier_params)
    if @carrier.save()
      flash[:notice] = "Transportadora cadastrada com sucesso."
      redirect_to @carrier
    else
      flash[:notice] = "Transportadora não cadastrada."
      render 'new'
    end
  end

  private
  def carrier_params
    params.require(:carrier).permit(:brand_name, :corporate_name, :email_domain, :registration_number, :address)
  end 
end
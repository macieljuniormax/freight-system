class CarriersController < ApplicationController
  before_action :set_carrier, only: [:show, :edit, :update]
  before_action :authenticate_user!
  
  def index
    @carriers = Carrier.all
  end

  def new
    @carrier = Carrier.new
  end

  def show; end

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

  def edit; end

  def update
      if @carrier.update(carrier_params)
        flash[:notice] = "Transportadora atualizada com sucesso"
        redirect_to @carrier
      else
        flash[:notice] = "Transportadora não atualizada."
        render 'edit'
      end
  end
  
  private
  def set_carrier
    @carrier = Carrier.find(params[:id])
  end

  def carrier_params
    params.require(:carrier).permit(:brand_name, :corporate_name, :email_domain, :registration_number, :address)
  end 
end
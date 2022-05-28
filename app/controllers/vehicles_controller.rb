class VehiclesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @vehicles = Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.carrier = current_user.carrier
    if @vehicle.save()
      flash[:notice] = "Veículo cadastrado com sucesso."
      redirect_to vehicles_path
    else
      flash[:notice] = "Veículo não cadastrado."
      render 'new'
    end
  end

  private
  def vehicle_params
    params.require(:vehicle).permit(:plate, :brand_name, :model, :year_manufacture, :capacity, :carrier)
  end 
end
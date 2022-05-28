class VehiclesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @vehicles = Vehicle.all
  end
  
end
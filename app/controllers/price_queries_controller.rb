class PriceQueriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @price_queries = PriceQuery.all
  end

  def new
    @price_query = PriceQuery.new
  end

  def search
    @carriers = []
    @volume = params[:height].to_f * params[:width].to_f * params[:length].to_f
    @height = params[:height]
    @width = params[:width]
    @length = params[:length]
    @weight = params[:weight]
    @distance = params[:distance]
    
    available_prices = Price.where("min_volume <= ? AND max_volume >= ? AND min_weight <= ? AND max_weight >= ?", @volume, @volume, @weight, @weight)
    available_deadlines = Deadline.where("min_distance <= ? AND max_distance >= ?", @distance, @distance)
    available_prices.each do |price|
      available_deadlines.each do |deadline|
        carrier = {}
        if price.carrier_id == deadline.carrier_id && price.carrier.active? && deadline.carrier.active?
          carrier[:price] = price.price_km * @distance.to_i
          carrier[:deadline] = deadline.deadline_days
          carrier[:carrier] = price.carrier
          @carriers << carrier
        end
      end
    end

    PriceQuery.create!(height: @height, width: @width,length: @length,weight: @weight,distance: @distance)
  
  end

  def create
    @price_query = PriceQuery.new(price_query_params)
    if @price_query.save()
      flash[:notice] = "Consulta realizada com sucesso."
      redirect_to search_price_queries_path
    else
      flash[:notice] = "Consulta não realizada"
      render 'new'
    end
  end

  private
  def price_query_params
    params.require(:price_query).permit(:height, :width, :length, :weight, :distance)
  end 
end
class DeadlinesController < ApplicationController
  before_action :authenticate_user!

  def index
    @deadlines = Deadline.all
  end

  def new
    @deadline = Deadline.new
  end

  def create
    @deadline = Deadline.new(deadline_params)
    @deadline.carrier = current_user.carrier
    if @deadline.save()
      flash[:notice] = "Novo prazo cadastrado com sucesso."
      redirect_to deadlines_path
    else
      flash[:notice] = "Novo prazo não cadastrado."
      render 'new'
    end
  end

  private
  def deadline_params
    params.require(:deadline).permit(:max_distance, :min_distance, :deadline_days, :carrier, presence: true)
  end 
end
class DeadlinesController < ApplicationController
  before_action :set_deadline, only: [:edit, :update]
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

  def edit; end
  
  def update
    if @deadline.update(deadline_params)
      flash[:notice] = "Prazo atualizado com sucesso."
      redirect_to deadlines_path
    else
      flash[:notice] = "Prazo não atualizado."
      render 'edit'
    end
  end
  

  private
  def set_deadline
    @deadline = Deadline.find(params[:id])
  end

  def deadline_params
    params.require(:deadline).permit(:max_distance, :min_distance, :deadline_days, :deadline)
  end 
end
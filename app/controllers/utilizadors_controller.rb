class UtilizadorsController < ApplicationController

  before_filter :authenticate, :only => [:index, :show, :edit, :update, :new, :destroy]
  before_filter :correct_utilizador, :only => [:edit, :update, :destroy]
  before_filter :ultimoAdmin, :only => [:destroy]
  
  def ultimoAdmin
    if(estatuto_admin?)
      redirect_to utilizadors_path, notice: "O ultimo administrador no sistema!" unless Utilizador.find_all_by_estatuto("Administrador").count > 1
    end
  end

  def index
    @utilizadors = Utilizador.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @utilizadors }
    end
  end

  # GET /utilizadors/1
  # GET /utilizadors/1.json
  def show
    @utilizador = Utilizador.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @utilizador }
    end
  end

  def new
    @utilizador = Utilizador.new

    respond_to do |format|
      format.html
      format.json {render json: @utilizador}
    end
  end

  def edit
    @utilizador = Utilizador.find(params[:id])
  end

  def update
    @utilizador = Utilizador.find(params[:id])

    respond_to do |format|
      if @utilizador.update_attributes(params[:utilizador])
        format.html { redirect_to @utilizador, notice: 'Utilizador was sucessfully updated.'}
        format.json { head :ok}
      else
        format.html { render action: "edit" }
        format.json { render json: @utilizador.errors, status: :unprocessable_entity}
      end
    end
  end

  def create
    @grupo = Grupo.find(params[:utilizador][:grupo_id])
    @utilizador = @grupo.utilizadors.build(params[:utilizador])
    @utilizador.save
    redirect_to utilizador_path(@utilizador)
  end

  def destroy
    @utilizador = Utilizador.find(params[:id])
    @utilizador.destroy
    
    respond_to do |format|
      if @utilizador == current_utilizador
        format.html { redirect_to root_path }
        format.json { head :ok}
      else
        format.html { redirect_to utilizadors_path }
        format.json { head :ok}
      end
    end
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

  def correct_utilizador
    @utilizador = Utilizador.find(params[:id])
    redirect_to utilizadors_path, notice: "Apenas administradores ou o proprio utilizador!" unless current_utilizador?(@utilizador) || estatuto_admin?
  end
end

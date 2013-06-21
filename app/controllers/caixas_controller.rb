class CaixasController < ApplicationController

  before_filter :authenticate, :only => [:new, :index, :show, :edit, :update, :destroy]
  before_filter :correct_utilizador, :only => [:edit, :update]
  before_filter :correct_utilizadorAdmin, :only => [:destroy]

  def correct_utilizador
    @caixa = current_utilizador.caixas.find_by_id(params[:id])
    redirect_to caixas_path, notice: "So o utilizador que criou este item pode edita-lo!" if @caixa.nil?
  end

  def correct_utilizadorAdmin
    @caixa = current_utilizador.caixas.find_by_id(params[:id])
    redirect_to caixas_path, notice: "So o administrador ou o utilizador que criou este item podem remove-lo!" if @caixa.nil? && !estatuto_admin?
  end

  # GET /caixas
  # GET /caixas.json
  def index
    @caixas = Caixa.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @caixas }
    end
  end

  # GET /caixas/1
  # GET /caixas/1.json
  def show
    @caixa = Caixa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @caixa }
    end
  end

  # GET /caixas/new
  # GET /caixas/new.json
  def new
    @caixa = Caixa.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @caixa }
    end
  end

  # GET /caixas/1/edit
  def edit
    @caixa = Caixa.find(params[:id])
  end

  # POST /caixas
  # POST /caixas.json
  def create
    @utilizador = Utilizador.find(current_utilizador.id)
    @caixa = @utilizador.caixas.build(params[:caixa])

    respond_to do |format|
      if @caixa.save
        format.html { redirect_to @caixa, notice: 'Caixa was successfully created.' }
        format.json { render json: @caixa, status: :created, location: @caixa }
      else
        format.html { render action: "new" }
        format.json { render json: @caixa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /caixas/1
  # PUT /caixas/1.json
  def update
    @caixa = Caixa.find(params[:id])

    respond_to do |format|
      if @caixa.update_attributes(params[:caixa])
        format.html { redirect_to @caixa, notice: 'Caixa was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @caixa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /caixas/1
  # DELETE /caixas/1.json
  def destroy
    @caixa = Caixa.find(params[:id])
    @caixa.destroy

    respond_to do |format|
      format.html { redirect_to caixas_url }
      format.json { head :ok }
    end
  end

  def authenticate
    deny_access unless signed_in?
  end

end

class OrcamentosController < ApplicationController

  before_filter :authenticate, :only => [:new, :show, :index, :edit, :update, :destroy]
  before_filter :estatuto_admin, :only => [:destroy]
  before_filter :grupo_correcto, :only => [:show, :edit, :update]

  def estatuto_admin
    redirect_to orcamentos_path, notice: "Precisa de ser administrador!" unless estatuto_admin?
  end

  def grupo_correcto
    @grupo = Grupo.find(current_utilizador.grupo_id)
    @orcamento = @grupo.orcamentos.find_by_id(params[:id])
    redirect_to orcamentos_path, notice: "Precisa de ser administrador ou de pertencer ao grupo que propos o orcamento" if @orcamento.nil? && !estatuto_admin?
  end

  # GET /orcamentos
  # GET /orcamentos.json
  def index
    if (estatuto_admin?)
     @orcamentos = Orcamento.all

     respond_to do |format|
       format.html # index.html.erb
       format.json { render json: @orcamentos }
    end
    else
      @orcamentos = Orcamento.find_all_by_grupo_id(current_utilizador.grupo_id)

      respond_to do |format|
        format.html
        format.json { render json: @orcamentos }
      end
    end
  end

  # GET /orcamentos/1
  # GET /orcamentos/1.json
  def show
    @orcamento = Orcamento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @orcamento }
    end
  end

  # GET /orcamentos/new
  # GET /orcamentos/new.json
  def new
    @orcamento = Orcamento.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @orcamento }
    end
  end

  # GET /orcamentos/1/edit
  def edit
    @orcamento = Orcamento.find(params[:id])
  end

  # POST /orcamentos
  # POST /orcamentos.json
  def create
    @grupo = Grupo.find(current_utilizador.grupo_id)
    @orcamento = @grupo.orcamentos.build(params[:orcamento])

    respond_to do |format|
      if @orcamento.save
        format.html { redirect_to @orcamento, notice: 'Orcamento was successfully created.' }
        format.json { render json: @orcamento, status: :created, location: @orcamento }
      else
        format.html { render action: "new" }
        format.json { render json: @orcamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orcamentos/1
  # PUT /orcamentos/1.json
  def update
    @orcamento = Orcamento.find(params[:id])

    respond_to do |format|
      if @orcamento.update_attributes(params[:orcamento])
        format.html { redirect_to @orcamento, notice: 'Orcamento was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @orcamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orcamentos/1
  # DELETE /orcamentos/1.json
  def destroy
    @orcamento = Orcamento.find(params[:id])
    @orcamento.destroy

    respond_to do |format|
      format.html { redirect_to orcamentos_url }
      format.json { head :ok }
    end
  end

  def authenticate
    deny_access unless signed_in?
  end
end

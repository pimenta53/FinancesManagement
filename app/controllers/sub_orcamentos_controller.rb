class SubOrcamentosController < ApplicationController

  before_filter :authenticate, :only => [:show, :index, :new, :edit, :update, :destroy]
  before_filter :correct_grupo, :only => [:show, :edit, :update]
  before_filter :correct_for_new, :only => [:new]
  after_filter :actualizaOrcamento, :only => [:create, :update, :destroy]

  def actualizaOrcamento  
    @orcamento = Orcamento.find_by_id(params[:orcamento_id])
    orcamentoValorActual(@orcamento)
  end

  def correct_for_new
    @grupo = Grupo.find(current_utilizador.grupo_id)
    @orcamento = @grupo.orcamentos.find_by_id(params[:orcamento_id])
    redirect_to orcamentos_path, notice: "Apenas administradores ou utilizadores pertencentes ao grupo que criou o orcamento principal" if @orcamento.nil? && !estatuto_admin?
  end

  def correct_grupo
    @grupo = Grupo.find(current_utilizador.grupo_id)
    @orcamento = @grupo.orcamentos.find_by_id(params[:orcamento_id])
    if !@orcamento.nil?
      @sub_orcamento = @orcamento.sub_orcamentos.find_by_id(params[:id])
    end
    redirect_to orcamentos_path, notice: "Apenas administradores ou utilizadores pertencentes ao grupo do orcamento principal" if @sub_orcamento.nil? && !estatuto_admin?
  end

  # GET /sub_orcamentos
  # GET /sub_orcamentos.json
  def index
    @sub_orcamentos = SubOrcamento.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sub_orcamentos }
    end
  end

  # GET /sub_orcamentos/1
  # GET /sub_orcamentos/1.json
  def show
    @sub_orcamento = SubOrcamento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sub_orcamento }
    end
  end

  # GET /sub_orcamentos/new
  # GET /sub_orcamentos/new.json
  def new
    @orcamento = Orcamento.find(params[:orcamento_id])
    @sub_orcamento = SubOrcamento.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sub_orcamento }
    end
  end

  # GET /sub_orcamentos/1/edit
  def edit
    @orcamento = Orcamento.find(params[:orcamento_id])
    @sub_orcamento = SubOrcamento.find(params[:id])
  end

  # POST /sub_orcamentos
  # POST /sub_orcamentos.json
  def create
    @orcamento = Orcamento.find(params[:orcamento_id])
    @sub_orcamento = @orcamento.sub_orcamentos.build(params[:sub_orcamento])
    @sub_orcamento.utilizador = current_utilizador

    respond_to do |format|
      if @sub_orcamento.save
        format.html { redirect_to orcamento_sub_orcamento_path(@orcamento,@sub_orcamento), notice: 'Sub orcamento was successfully created.' }
        format.json { render json: @sub_orcamento, status: :created, location: @sub_orcamento }
      else
        format.html { render action: "new" }
        format.json { render json: @sub_orcamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sub_orcamentos/1
  # PUT /sub_orcamentos/1.json
  def update
    @sub_orcamento = SubOrcamento.find(params[:id])
    @orcamento = Orcamento.find(params[:orcamento_id])
    
    respond_to do |format|
      if @sub_orcamento.update_attributes(params[:sub_orcamento])
        format.html { redirect_to orcamento_sub_orcamento_path(@orcamento,@sub_orcamento), notice: 'Sub orcamento was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @sub_orcamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_orcamentos/1
  # DELETE /sub_orcamentos/1.json
  def destroy
    @sub_orcamento = SubOrcamento.find(params[:id])
    @sub_orcamento.destroy

    respond_to do |format|
      format.html { redirect_to sub_orcamentos_url }
      format.json { head :ok }
    end
  end

  def authenticate
    deny_access unless signed_in?
  end
end

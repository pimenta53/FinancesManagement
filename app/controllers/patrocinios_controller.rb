class PatrociniosController < ApplicationController

  @@filter_id = 0
  before_filter :authenticate, :only => [:index, :show, :new, :edit, :update, :destroy]
  before_filter :estatuto_drepAdmin, :only => [:index, :show, :destroy]
  before_filter :grupo_drep, :only => [:new, :edit, :update]
  after_filter :httplink, :only => [:create, :update]
  
  def httplink
    @patrocinio = Patrocinio.find(@@filter_id)
    (@patrocinio.link = ("http://" << @patrocinio.link)) unless ((@patrocinio.link).include? "http://") || (@patrocinio.link).empty?
    @patrocinio.save
  end

  def estatuto_drepAdmin
    redirect_to utilizadors_path, notice: "Apenas administradores ou utilizadores pertencentes ao DREP!" unless grupo_drep? || estatuto_admin?
  end

  def grupo_drep
    redirect_to utilizadors_path, notice: "Apenas administradores ou utilizadores pertencentes ao DREP!" unless grupo_drep? || estatuto_admin?
  end

  # GET /patrocinios
  # GET /patrocinios.json
  def index
    @patrocinios = Patrocinio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @patrocinios }
    end
  end

  # GET /patrocinios/1
  # GET /patrocinios/1.json
  def show
    @patrocinio = Patrocinio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @patrocinio }
    end
  end

  # GET /patrocinios/new
  # GET /patrocinios/new.json
  def new
    @patrocinio = Patrocinio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @patrocinio }
    end
  end

  # GET /patrocinios/1/edit
  def edit
    @patrocinio = Patrocinio.find(params[:id])
  end

  # POST /patrocinios
  # POST /patrocinios.json
  def create
    @utilizador = Utilizador.find(current_utilizador.id)
    @patrocinio = @utilizador.patrocinios.build(params[:patrocinio])

    respond_to do |format|
      if @patrocinio.save
        @@filter_id = @patrocinio.id
        format.html { redirect_to @patrocinio, notice: 'Patrocinio was successfully created.' }
        format.json { render json: @patrocinio, status: :created, location: @patrocinio }
      else
        format.html { render action: "new" }
        format.json { render json: @patrocinio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /patrocinios/1
  # PUT /patrocinios/1.json
  def update
    @patrocinio = Patrocinio.find(params[:id])

    respond_to do |format|
      if @patrocinio.update_attributes(params[:patrocinio])
        @@filter_id = @patrocinio.id
        format.html { redirect_to @patrocinio, notice: 'Patrocinio was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @patrocinio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patrocinios/1
  # DELETE /patrocinios/1.json
  def destroy
    @patrocinio = Patrocinio.find(params[:id])
    @patrocinio.destroy

    respond_to do |format|
      format.html { redirect_to patrocinios_url }
      format.json { head :ok }
    end
  end

  def authenticate
    deny_access unless signed_in?
  end
end

class SessionsController < ApplicationController
  def new
    @title = "Login"
  end

  def create
    utilizador = Utilizador.authenticate(params[:session][:username],
                                         params[:session][:password])
    if utilizador.nil?
      flash.now[:error] = "Username/password invalido!"
      render 'new'
    else
      sign_in(utilizador)
      redirect_to :controller => 'caixas', :action => 'index'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end

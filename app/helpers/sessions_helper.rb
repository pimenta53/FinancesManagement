module SessionsHelper

  def sign_in(utilizador)
   cookies.permanent.signed[:remember_token] = [utilizador.id, utilizador.email]
   self.current_utilizador = utilizador
  end

  def current_utilizador=(utilizador)
    @current_utilizador = utilizador
  end

  def current_utilizador 
    @current_utilizador ||= utilizador_from_remember_token
  end

  def signed_in?
    !current_utilizador.nil?
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_utilizador = nil
  end

  def deny_access
    redirect_to root_path, :notice => "Por favor, efetue o login para aceder a esta pagina!"
  end

  def current_utilizador?(utilizador)
    utilizador == current_utilizador
  end

  def estatuto_admin?
    current_utilizador.estatuto == "Administrador"
  end

  def grupo_drep?
    Grupo.find(current_utilizador.grupo_id).nome == "DREP"
  end

  def estatuto_director?
    current_utilizador.estatuto == "Director"
  end

  private

  def utilizador_from_remember_token
    Utilizador.authenticate_with_email(*remember_token)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil,nil]
  end

end

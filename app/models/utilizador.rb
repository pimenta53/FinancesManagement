class Utilizador < ActiveRecord::Base
  belongs_to :grupo
  has_many :patrocinios
  has_many :caixas

  validates :nome, :presence => true
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true, :uniqueness => true
  validates :estatuto, :presence => true

  def has_password?(pass)
    password == pass
  end

  def self.authenticate(username, pass)
    utilizador = find_by_username(username)
    return nil if utilizador.nil?
    return utilizador if utilizador.password == pass
  end

  def self.authenticate_with_email(id, cookie_email)
    utilizador = find_by_id(id)
    (utilizador && utilizador.email == cookie_email) ? utilizador : nil
  end

end

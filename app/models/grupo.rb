class Grupo < ActiveRecord::Base
  validates :nome, :presence => true, :uniqueness => true
  validates :descricao, :presence => true

  has_many :utilizadors, :dependent => :destroy
  has_many :orcamentos
  has_many :sub_orcamentos, :through => :orcamentos
end

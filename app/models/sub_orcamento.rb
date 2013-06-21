class SubOrcamento < ActiveRecord::Base
  belongs_to :orcamento
  belongs_to :utilizador

  validates :descricao, :presence => true
  validates_numericality_of :valor, :greater_than => 0
  validates :estado, :presence => true
end

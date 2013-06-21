class Caixa < ActiveRecord::Base
  belongs_to :utilizador
  
  validates :nome, :presence => true
  validates_numericality_of :valor, :greater_than => 0
  validates :data, :presence => true
  validates :estado, :presence => true  

end

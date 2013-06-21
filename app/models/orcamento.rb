class Orcamento < ActiveRecord::Base
  belongs_to :grupo
  has_many :sub_orcamentos, :dependent => :destroy

  validates :nome, :presence => true, :uniqueness => true
  validates :data, :presence => true
end

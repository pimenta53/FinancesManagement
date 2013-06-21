class Patrocinio < ActiveRecord::Base
  belongs_to :utilizador
  
  validates :nome, :presence => true, :uniqueness => true
  validates_numericality_of :valor, :greater_than => 0
  validate :inicio_before_fim

  has_attached_file :photo, :styles => {:small => "200x200>"},
                    :url => "/system/:attachment/:nome/:style/:filename",
                    :path => ":rails_root/public/system/:attachment/:nome/:style/:filename"

  def inicio_before_fim
    return unless datainicio and datafim
    errors.add(:datainicio, "precisa de ser anterior a datafim") unless datainicio < datafim
  end
end

class ChangeEstadoInSubOrcamento < ActiveRecord::Migration
  def up
    change_column :sub_orcamentos, :estado, :string, :default => "Em Espera"
  end

  def down
    change_column :sub_orcamentos, :estado, :string
  end
end

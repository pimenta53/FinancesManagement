class ChangeValorInOrcamentos < ActiveRecord::Migration
  def self.up
    change_column :orcamentos, :valor, :float, :default => 0.0
  end

  def self.down
    change_column :orcamentos, :valor, :float
  end
end

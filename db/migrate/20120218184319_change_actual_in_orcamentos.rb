class ChangeActualInOrcamentos < ActiveRecord::Migration
  def up
    change_column :orcamentos, :actual, :boolean, :default => true
  end

  def down
    change_column :orcamentos, :actual, :boolean
  end
end

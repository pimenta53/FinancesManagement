class CreateSubOrcamentos < ActiveRecord::Migration
  def change
    create_table :sub_orcamentos do |t|
      t.string :descricao
      t.float :valor
      t.string :estado
      t.references :orcamento
      t.references :utilizador

      t.timestamps
    end
    add_index :sub_orcamentos, :orcamento_id
    add_index :sub_orcamentos, :utilizador_id
  end
end

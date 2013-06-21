class CreateOrcamentos < ActiveRecord::Migration
  def change
    create_table :orcamentos do |t|
      t.string :nome
      t.string :descricao
      t.float :valor
      t.date :data
      t.boolean :actual
      t.references :grupo

      t.timestamps
    end
    add_index :orcamentos, :grupo_id
  end
end

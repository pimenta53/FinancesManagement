class CreatePatrocinios < ActiveRecord::Migration
  def change
    create_table :patrocinios do |t|
      t.string :nome
      t.string :descricao
      t.float :valor
      t.date :datainicio
      t.date :datafim
      t.references :utilizador

      t.timestamps
    end
    add_index :patrocinios, :utilizador_id
  end
end

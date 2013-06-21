class CreateCaixas < ActiveRecord::Migration
  def change
    create_table :caixas do |t|
      t.string :nome
      t.string :descricao
      t.float :valor
      t.string :estado
      t.date :data
      t.references :utilizador

      t.timestamps
    end
    add_index :caixas, :utilizador_id
  end
end

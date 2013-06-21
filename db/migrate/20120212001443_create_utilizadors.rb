class CreateUtilizadors < ActiveRecord::Migration
  def change
    create_table :utilizadors do |t|
      t.string :nome
      t.string :username
      t.string :password
      t.string :email
      t.references :grupo

      t.timestamps
    end
    add_index :utilizadors, :grupo_id
  end
end

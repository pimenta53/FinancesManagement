class AddEstatutoToUtilizadors < ActiveRecord::Migration
  def change
    add_column :utilizadors, :estatuto, :string
  end
end

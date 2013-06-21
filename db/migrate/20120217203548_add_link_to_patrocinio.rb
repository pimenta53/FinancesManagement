class AddLinkToPatrocinio < ActiveRecord::Migration
  def change
    add_column :patrocinios, :link, :string
  end
end

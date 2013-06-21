class AddPhotoColumnsToPatrocinio < ActiveRecord::Migration
  def self.up
    change_table :patrocinios do |t|
      t.has_attached_file :photo
    end
  end

  def self.down
    drop_attached_file :patrocinios, :photo
  end
end

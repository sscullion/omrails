class RemoveImageUrlFromPins < ActiveRecord::Migration
  def up
    remove_column :pins, :image_url
  end

  def down
    add_column :pins, :image_url, :string
  end
end

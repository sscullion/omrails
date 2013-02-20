class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :pins, :image_url, :image_remote_url
  end
end